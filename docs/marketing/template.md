# Marketing Website Template

This template provides a complete, production-ready framework for building modern marketing websites with Bardenhagen standards.

## Quick Start

### 1. Clone This Template
```bash
git clone https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz.git your-project
cd your-project
npm install
```

### 2. Customize for Your Project
```bash
# Update project name
sed -i 's/MyDesk/YourProject/g' package.json app/layout.tsx

# Set up environment
cp .env.example .env.local
# Edit .env.local with your values (GA ID, API endpoints, etc.)

# Update branding
# - Update logo in public/logo.png
# - Update favicon in public/favicon.ico
# - Update colors in app/globals.css (--accent, --bg, etc.)
```

### 3. Verify Everything Works
```bash
npm run type-check  # TypeScript validation
npm run lint        # Code quality check
npm run build       # Production build
npm run dev         # Start dev server
```

## What's Included

### Standards Documentation
- **MARKETING_STANDARDS.md** - Complete reference covering performance, SEO, accessibility, security, analytics
- **IMPLEMENTATION_CHECKLIST.md** - 10-phase implementation guide with success metrics
- **SEO_CHECKLIST.md** - On-page, technical, and off-page SEO best practices
- **SECURITY_GUIDE.md** - OWASP Top 10 implementation for web applications
- **ACCESSIBILITY_GUIDE.md** - WCAG 2.1 Level AA compliance guide
- **TEMPLATE_GUIDE.md** - Detailed template structure and customization guide

### Project Structure
```
your-project/
├── app/
│   ├── components/         # Reusable React components
│   ├── lib/
│   │   ├── analytics.ts    # Event tracking system
│   │   └── utils.ts        # Utility functions
│   ├── hooks/              # Custom React hooks
│   ├── styles/             # Global CSS
│   ├── page.tsx            # Homepage
│   └── layout.tsx          # Root layout
├── public/                 # Static assets (images, fonts)
├── docs/                   # Documentation (this folder)
├── .env.example            # Environment variables template
├── CLAUDE.md               # Claude Code setup
├── package.json            # Dependencies and scripts
└── next.config.js          # Next.js configuration
```

## Key Technologies

- **Framework**: Next.js 16 (React 19)
- **Styling**: Tailwind CSS + custom CSS
- **Animations**: Framer Motion
- **Analytics**: Google Analytics 4
- **Language**: TypeScript (strict mode)
- **Deployment**: Vercel

## Standards & Compliance

This template ensures:

✅ **Performance** - 95+ Lighthouse scores (LCP <2.5s, FID <100ms, CLS <0.1)
✅ **SEO** - Complete optimization with schema.org markup
✅ **Accessibility** - WCAG 2.1 Level AA compliant
✅ **Security** - OWASP Top 10 implementation
✅ **Analytics** - Full event tracking for conversions and user behavior
✅ **Mobile** - Responsive design with 44x44px touch targets

## Getting Started Phases

### Phase 1: Foundation (Week 1)
- [ ] Clone template and install dependencies
- [ ] Configure environment variables
- [ ] Update branding (logo, colors, typography)
- [ ] Customize metadata in app/layout.tsx
- [ ] Verify build succeeds

### Phase 2: Content & Structure (Week 1-2)
- [ ] Update Hero section copy
- [ ] Add feature descriptions
- [ ] Create service/product pages
- [ ] Update testimonials
- [ ] Add real images

### Phase 3: Analytics (Week 2)
- [ ] Set up Google Analytics 4
- [ ] Update NEXT_PUBLIC_GA_ID in .env.local
- [ ] Configure goal tracking
- [ ] Test event tracking in GA4 real-time

### Phase 4: SEO (Week 2-3)
- [ ] Update meta tags (title, description, canonical)
- [ ] Implement structured data (schema markup)
- [ ] Optimize images with alt text
- [ ] Set up sitemap.xml
- [ ] Submit to Google Search Console

### Phase 5: Accessibility (Week 3)
- [ ] Run Axe DevTools - aim for 0 violations
- [ ] Test keyboard navigation
- [ ] Test with screen reader
- [ ] Check color contrast
- [ ] Verify all images have alt text

### Phase 6: Performance (Week 3-4)
- [ ] Run Lighthouse audit
- [ ] Optimize Core Web Vitals
- [ ] Compress images (target <200KB for hero)
- [ ] Enable caching headers
- [ ] Verify bundle size <500KB gzipped

### Phase 7: Testing & QA (Week 4)
- [ ] Test all forms and CTAs
- [ ] Verify email notifications
- [ ] Test on mobile devices
- [ ] Check all links are working
- [ ] Final Lighthouse run

### Phase 8: Deployment (Week 4)
- [ ] Connect Vercel project
- [ ] Set production environment variables
- [ ] Deploy to production
- [ ] Verify analytics tracking
- [ ] Set up monitoring alerts

### Phase 9: Launch (Week 5)
- [ ] Monitor Core Web Vitals
- [ ] Check Google Search Console
- [ ] Collect user feedback
- [ ] Review conversion metrics
- [ ] Document launch results

### Phase 10: Optimization (Ongoing)
- [ ] Review monthly analytics
- [ ] Update content based on performance
- [ ] Monitor rankings and organic traffic
- [ ] A/B test CTAs and copy
- [ ] Quarterly security audit

## Component Reference

### Pre-built Components
The template includes these pre-built, reusable components:

1. **Hero** - Main hero section with CTA
2. **Features** - Feature grid with icons
3. **ModuleGrid** - Product/service modules
4. **Testimonials** - Customer testimonials
5. **Pricing** - Pricing table
6. **CTA Sections** - Call-to-action sections
7. **Contact** - Contact form

### Add-on Components (from MyDesk)
Optionally add these interactive components:

1. **AnimatedStats** - Counter animations for metrics
2. **InteractiveFeatureCard** - Interactive cards with hover animations
3. **DynamicBackground** - Particle animation system
4. **ComparisonTable** - Feature comparison table
5. **TestimonialCarousel** - Testimonial carousel
6. **DemoVideo** - Video player section
7. **EnhancedCTA** - Animated CTAs
8. **ComplianceBadges** - Security/compliance badges
9. **FeatureShowcase** - Interactive feature tabs

See MARKETING_STANDARDS.md for component implementation patterns.

## Environment Variables

```bash
# Google Analytics
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX

# API Endpoints (if applicable)
NEXT_PUBLIC_API_URL=https://api.example.com
SECRET_API_KEY=sk_...

# Email Service (if using contact forms)
NEXT_PUBLIC_EMAIL_SERVICE=sendgrid
SECRET_SENDGRID_KEY=...

# Database (if applicable)
DATABASE_URL=postgresql://user:pass@localhost/db
```

## Deployment

### Vercel (Recommended)
```bash
npm install -g vercel
vercel
# Follow prompts
```

### Manual
1. Push to GitHub
2. Connect repository to Vercel
3. Set environment variables
4. Deploy

## Maintenance Schedule

### Daily
- Monitor error logs
- Check uptime

### Weekly
- Review analytics
- Check user feedback
- Test critical paths

### Monthly
- Update content
- Review performance metrics
- Audit accessibility

### Quarterly
- Full performance audit
- SEO audit
- Security scan

### Annually
- Major version upgrades
- Design refresh evaluation
- Technology stack review

## Troubleshooting

### Lighthouse Score Dropped
1. Check recent commits
2. Profile JavaScript bundle
3. Optimize images
4. Remove unused code
5. Verify CDN caching

### Analytics Not Tracking
1. Check GA ID in environment
2. Verify gtag script loaded
3. Check browser console
4. Test in GA4 real-time

### Accessibility Issues
1. Run Axe DevTools
2. Check color contrast
3. Test keyboard navigation
4. Verify ARIA labels

### Slow Page Load
1. Check Core Web Vitals
2. Optimize LCP (images)
3. Reduce FID (JavaScript)
4. Fix CLS (fonts, images)

## Resources

### Documentation in This Template
- MARKETING_STANDARDS.md - Complete standards reference
- IMPLEMENTATION_CHECKLIST.md - Step-by-step guide
- SEO_CHECKLIST.md - SEO best practices
- SECURITY_GUIDE.md - Security implementation
- ACCESSIBILITY_GUIDE.md - Accessibility compliance
- TEMPLATE_GUIDE.md - Template customization

### External Resources
- [Next.js Documentation](https://nextjs.org/docs)
- [Tailwind CSS](https://tailwindcss.com)
- [Framer Motion](https://www.framer.com/motion)
- [Web.dev](https://web.dev)
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)

## Support

1. Check the documentation first (MARKETING_STANDARDS.md)
2. Review the troubleshooting section
3. Search GitHub issues
4. Create an issue with reproduction steps

---

**Template Version**: 1.0
**Last Updated**: 2026-07-28
**Maintained By**: Bardenhagen Development Team
