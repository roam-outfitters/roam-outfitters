# Roam Outfitters - Agent Guide

## What This Is

Marketing site for Roam Outfitters, a fly fishing guide service in Montana's Gallatin Valley. Single-page static site deployed to GitHub Pages.

## Tech Stack

- **Astro 5** — static site generator
- **Tailwind CSS v4** — via `@tailwindcss/vite` plugin (NOT `@astrojs/tailwind`, which is v3 only)
- **Sharp** — image optimization (Astro's built-in image service)
- **Self-hosted fonts** — Cormorant Garamond (serif) + Inter (sans) via `@fontsource`

## Commands

```
npm run dev       # Start dev server
npm run build     # Production build to dist/
npm run preview   # Preview production build
npm run check     # Astro type checking
```

## Project Structure

```
src/
  pages/index.astro          # Single page, composes all sections
  layouts/BaseLayout.astro   # HTML shell, grain overlay, scroll reveal observer
  components/
    Navigation.astro         # Fixed nav, transparent → solid on scroll
    Hero.astro               # Full-screen carousel (6 images), mouse parallax
    About.astro              # Bio + stats with count-up animation
    Waters.astro             # Rivers info with parallax photo dividers
    Trips.astro              # Pricing cards with accordion
    Gallery.astro            # Photo grid with lightbox
    Contact.astro            # Contact info + CTA
    Footer.astro             # Footer with links and social
  styles/global.css          # All custom CSS (scroll reveals, animations, etc.)
  assets/images/
    carousel/                # Hero + parallax divider source images
    gallery/                 # Gallery source images
    about/                   # Brett's photo
public/                      # Favicons, og:image (served as-is)
```

## Key Architecture Decisions

- **Base URL is `/roam-outfitters/`** — all asset paths must account for this. Use `import.meta.env.BASE_URL` for links.
- **Tailwind v4 config** lives in `@theme` block inside `global.css`, not a separate config file.
- **Images go in `src/assets/images/`** so Astro processes and optimizes them. Don't put content images in `public/`.
- **Hero carousel LCP optimization** — only the first image is in the initial HTML. Remaining 5 are injected via JS after `window.load` to avoid blocking LCP.
- **Parallax photo dividers** use `getImage()` for optimized AVIF, with `bg-fixed` fallback to `scroll` on iOS/touch devices.
- **`inlineStylesheets: 'always'`** in astro config eliminates render-blocking CSS.
- **Scroll reveal system** — elements with `data-reveal` attribute (values: `"left"`, `"right"`, `"up"`, `"scale"`, or empty) animate in via IntersectionObserver. A `<script is:inline>` in `<head>` adds `.js` class to `<html>` to prevent FOIC.

## Design System

- **Color palette**: Stone (Tailwind defaults) + accent gold `#c49a3c`
- **Typography**: Cormorant Garamond for headings/display, Inter for body
- **Accent lines**: Gold `accent-line` / `accent-line-center` classes under section headings
- **Film grain**: SVG feTurbulence overlay at ~3.5% opacity (hidden with `prefers-reduced-motion`)
- **All animations** respect `prefers-reduced-motion: reduce`

## Accessibility Gotcha

`text-stone-500` fails WCAG AA contrast on both `bg-stone-900` and `bg-stone-950`. Use `text-stone-400` on dark backgrounds, `text-stone-600` on light backgrounds.

## Original Assets

Raw/original photos live in `my_assets/` (gitignored). Processed versions are committed in `src/assets/images/`.
