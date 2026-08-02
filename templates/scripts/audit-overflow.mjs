#!/usr/bin/env node

/**
 * DR Standard 01 — Overflow Audit Script
 *
 * Fails the build if any element causes horizontal scrolling at any viewport width.
 * Tests at: 320, 360, 390, 412, 430, 768, 1024px
 *
 * Installation:
 * 1. Copy this file to scripts/audit-overflow.mjs
 * 2. Add to package.json: "audit:overflow": "node scripts/audit-overflow.mjs http://localhost:3000 /"
 * 3. Install Playwright: npm install -D @playwright/test
 *
 * Usage:
 * npm run audit:overflow
 * node scripts/audit-overflow.mjs <url> <path1> <path2> ...
 * node scripts/audit-overflow.mjs https://example.com / /about /products
 *
 * Reference: https://digitalresponse.com.au/standards
 */

import { chromium } from 'playwright';

const VIEWPORTS = [320, 360, 390, 412, 430, 768, 1024];
const BASE_URL = process.argv[2] || 'http://localhost:3000';
const PATHS = process.argv.slice(3).length > 0 ? process.argv.slice(3) : ['/'];

let hasErrors = false;

async function auditPage(browser, url, viewport) {
  // Playwright's API is newContext() — createBrowserContext() is Puppeteer's.
  const context = await browser.newContext();
  const page = await context.newPage();

  try {
    await page.setViewportSize({ width: viewport, height: 800 });
    await page.goto(url, { waitUntil: 'networkidle' });

    // Check for horizontal scrollbar
    const hasHorizontalScroll = await page.evaluate(() => {
      return window.innerWidth < document.documentElement.scrollWidth;
    });

    if (hasHorizontalScroll) {
      // Find problematic elements
      const overflowElements = await page.evaluate(() => {
        const elements = [];
        document.querySelectorAll('*').forEach((el) => {
          const rect = el.getBoundingClientRect();
          if (rect.right > window.innerWidth && rect.width > 0) {
            elements.push({
              tag: el.tagName,
              width: rect.width,
              right: rect.right,
              className: el.className,
              innerHTML: el.innerHTML.substring(0, 100),
            });
          }
        });
        return elements.slice(0, 5); // Top 5 culprits
      });

      console.error(
        `❌ Horizontal scroll detected at ${viewport}px on ${url.replace(BASE_URL, '')}`
      );
      overflowElements.forEach((el) => {
        console.error(
          `   → <${el.tag.toLowerCase()}> (${el.width.toFixed(0)}px wide, extends to ${el.right.toFixed(0)}px) [${el.className}]`
        );
      });
      hasErrors = true;
    } else {
      console.log(`✓ ${viewport}px: ${url.replace(BASE_URL, '')}`);
    }
  } catch (error) {
    console.error(`Error testing ${url} at ${viewport}px:`, error.message);
    hasErrors = true;
  } finally {
    await context.close();
  }
}

async function runAudit() {
  const browser = await chromium.launch();

  try {
    for (const path of PATHS) {
      const url = BASE_URL + path;
      console.log(`\n📏 Auditing ${url}`);

      for (const viewport of VIEWPORTS) {
        await auditPage(browser, url, viewport);
      }
    }

    if (hasErrors) {
      console.error('\n❌ Audit failed. Fix horizontal scrolling and try again.');
      console.error('\nCommon causes:');
      console.error('  • repeat(auto-fit, minmax(300px, 1fr)) — the floor does not shrink.');
      console.error('    Use minmax(min(300px, 100%), 1fr)');
      console.error('  • w-[600px] or other hard-coded widths on decorative elements');
      console.error('  • w-screen or width: 100vw');
      console.error('  • Negative margins pushing content off-screen');
      console.error('  • Missing overflow-hidden on parent sections');
      console.error('  • A wide table not wrapped in an overflow-x-auto container');
      console.error('\nFix guide: https://digitalresponse.com.au/standards/01-responsive');
      process.exit(1);
    } else {
      console.log('\n✅ All tests passed! No horizontal overflow detected.');
      process.exit(0);
    }
  } finally {
    await browser.close();
  }
}

runAudit().catch((error) => {
  console.error('Fatal error:', error);
  process.exit(1);
});
