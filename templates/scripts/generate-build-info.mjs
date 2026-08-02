#!/usr/bin/env node

/**
 * Build Provenance — generate-build-info.mjs
 *
 * Writes a build-info.json holding the version, commit, branch, and build
 * timestamp so the running app can state exactly which code it is. Without
 * this, "is my fix deployed?" is unanswerable without digging through the
 * host's dashboard.
 *
 * Installation:
 *   1. Copy to scripts/generate-build-info.mjs
 *   2. Wire into package.json (see below)
 *   3. Read the JSON in your footer component
 *   4. Add the output path to .gitignore — it is a build artifact
 *
 * package.json:
 *   "predev":   "node scripts/generate-build-info.mjs",
 *   "prebuild": "node scripts/generate-build-info.mjs",
 *
 * `pre*` hooks run automatically before `npm run dev` / `npm run build`, so
 * every build regenerates this. Never hand-edit the output or commit it —
 * a stale committed copy is exactly the bug this exists to prevent.
 *
 * Env override: BUILD_INFO_OUT=path/to/build-info.json
 */

import { execSync } from 'node:child_process';
import { mkdirSync, writeFileSync, readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join, resolve } from 'node:path';

const rootDir = join(dirname(fileURLToPath(import.meta.url)), '..');

function safeExec(cmd) {
  try {
    return execSync(cmd, { cwd: rootDir, stdio: ['ignore', 'pipe', 'ignore'] })
      .toString()
      .trim();
  } catch {
    // Shallow clones and container builds often have no git history.
    return null;
  }
}

function readVersion() {
  try {
    return JSON.parse(readFileSync(join(rootDir, 'package.json'), 'utf8')).version ?? '0.0.0';
  } catch {
    return '0.0.0';
  }
}

// CI env vars come first: on Vercel, GitHub Actions, and most container builds
// the checkout is shallow or detached, so git reports the wrong branch — or
// nothing at all. Only fall back to git for local builds.
const commit =
  process.env.VERCEL_GIT_COMMIT_SHA ||
  process.env.GITHUB_SHA ||
  process.env.CF_PAGES_COMMIT_SHA ||
  safeExec('git rev-parse HEAD') ||
  'unknown';

const branch =
  process.env.VERCEL_GIT_COMMIT_REF ||
  process.env.GITHUB_HEAD_REF || // the PR's source branch
  process.env.GITHUB_REF_NAME || // push builds
  process.env.CF_PAGES_BRANCH ||
  safeExec('git rev-parse --abbrev-ref HEAD') ||
  'unknown';

// A dirty tree means the artifact does not correspond to any commit. Worth
// surfacing — it is almost always a local build mistaken for a deployed one.
const dirty = safeExec('git status --porcelain') ? true : false;

const buildInfo = {
  version: readVersion(),
  commit: commit === 'unknown' ? 'unknown' : commit.slice(0, 7),
  commitFull: commit,
  branch,
  buildTime: new Date().toISOString(),
  ...(dirty ? { dirty: true } : {}),
};

const outPath = process.env.BUILD_INFO_OUT
  ? resolve(rootDir, process.env.BUILD_INFO_OUT)
  : join(rootDir, 'src', 'generated', 'build-info.json');

mkdirSync(dirname(outPath), { recursive: true });
writeFileSync(outPath, JSON.stringify(buildInfo, null, 2) + '\n');

console.log(
  `[build-info] v${buildInfo.version} (${buildInfo.commit}${buildInfo.dirty ? '-dirty' : ''}) ` +
    `on ${buildInfo.branch} @ ${buildInfo.buildTime}`
);
