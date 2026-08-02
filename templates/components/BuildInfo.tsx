/**
 * BuildInfo — renders the running build's provenance.
 *
 * Pairs with templates/scripts/generate-build-info.mjs. Drop into your footer
 * so any environment can be identified at a glance: "is the fix live yet?"
 * becomes a look rather than a dashboard dig.
 *
 * Installation:
 *   1. Copy to src/components/BuildInfo.tsx
 *   2. Ensure the prebuild script has run (writes src/generated/build-info.json)
 *   3. Add `src/generated/` to .gitignore
 *   4. Render <BuildInfo /> in your footer
 *
 * This is a Server Component — the JSON is inlined at build time, so it costs
 * no client JS. Do not add "use client".
 */

import buildInfo from '@/generated/build-info.json';

interface BuildInfoData {
  version: string;
  commit: string;
  commitFull?: string;
  branch: string;
  buildTime: string;
  dirty?: boolean;
}

const info = buildInfo as BuildInfoData;

/** Set to your repo to make the commit a clickable link. */
const REPO_URL = process.env.NEXT_PUBLIC_REPO_URL ?? '';

export function BuildInfo({ appName = 'App' }: { appName?: string }) {
  const built = new Date(info.buildTime);

  return (
    <div className="text-xs text-slate-500 dark:text-slate-400">
      <span>
        {appName} v{info.version}
      </span>
      {' · '}
      {REPO_URL ? (
        <a
          href={`${REPO_URL}/commit/${info.commitFull ?? info.commit}`}
          target="_blank"
          rel="noopener noreferrer"
          className="underline"
        >
          {info.commit}
        </a>
      ) : (
        <span>{info.commit}</span>
      )}
      {info.dirty && <span title="Built from an uncommitted working tree"> (dirty)</span>}
      {' · '}
      {/*
        suppressHydrationWarning: the server renders in the host's timezone and
        the client in the viewer's, so the two strings legitimately differ.
        Without this, React logs a hydration mismatch on every page load.
      */}
      <time dateTime={info.buildTime} suppressHydrationWarning>
        {built.toLocaleString(undefined, {
          dateStyle: 'medium',
          timeStyle: 'short',
        })}
      </time>
    </div>
  );
}
