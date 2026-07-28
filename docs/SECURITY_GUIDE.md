# Security Implementation Guide

## OWASP Top 10 - MyDesk Implementation

### 1. Injection Prevention

#### SQL Injection (if using database)
```typescript
// ❌ WRONG - Vulnerable
const query = `SELECT * FROM users WHERE email = '${email}'`;

// ✅ CORRECT - Parameterized queries
const result = await db.query(
  'SELECT * FROM users WHERE email = $1',
  [email]
);
```

#### Command Injection
```typescript
// ❌ WRONG - Vulnerable
const result = exec(`convert ${filename}`);

// ✅ CORRECT - Use Node packages
const sharp = require('sharp');
await sharp(filename).toFile(outputPath);
```

### 2. Broken Authentication

#### Password Security
```typescript
// ✅ CORRECT - Use bcrypt for password hashing
import bcrypt from 'bcrypt';

const hashedPassword = await bcrypt.hash(password, 10);
const isValid = await bcrypt.compare(inputPassword, hashedPassword);
```

#### Session Management
```typescript
// ✅ CORRECT - Use secure sessions
const sessionOptions = {
  secure: true,           // HTTPS only
  httpOnly: true,         // No JavaScript access
  sameSite: 'strict',     // CSRF protection
  maxAge: 24 * 60 * 60,   // 24 hours
};
```

### 3. Sensitive Data Exposure

#### Environment Variables
```bash
# .env.local (never commit)
DATABASE_URL=postgresql://...
SECRET_API_KEY=sk_live_...
ENCRYPTION_KEY=...

# .env.example (commit this)
DATABASE_URL=postgresql://user:pass@localhost/db
SECRET_API_KEY=sk_test_...
ENCRYPTION_KEY=your_key_here
```

#### Data Encryption
```typescript
// ✅ CORRECT - Encrypt sensitive data
import crypto from 'crypto';

function encrypt(text: string, key: string) {
  const iv = crypto.randomBytes(16);
  const cipher = crypto.createCipheriv('aes-256-cbc', Buffer.from(key), iv);
  let encrypted = cipher.update(text, 'utf8', 'hex');
  encrypted += cipher.final('hex');
  return iv.toString('hex') + ':' + encrypted;
}
```

### 4. XML External Entities (XXE)

```typescript
// ❌ WRONG - Vulnerable to XXE
const parser = new (require('xml2js')).Parser();

// ✅ CORRECT - Disable XXE
const parser = new (require('xml2js')).Parser({
  checkChildrenOnly: false,
  removeNS: false,
  // Disable external entity resolution
  resolveNS: false,
});
```

### 5. Broken Access Control

#### Authorization Middleware
```typescript
// ✅ CORRECT - Check user permissions
export async function withAuth(handler: Function) {
  return async (req: Request) => {
    const token = req.headers.get('authorization')?.split(' ')[1];
    if (!token) return new Response('Unauthorized', { status: 401 });
    
    const user = await verifyToken(token);
    if (!user) return new Response('Forbidden', { status: 403 });
    
    return handler(req, user);
  };
}
```

#### Role-Based Access Control (RBAC)
```typescript
// ✅ CORRECT - Check user role
function hasPermission(user: User, permission: string): boolean {
  const rolePermissions = {
    admin: ['read', 'write', 'delete', 'manage_users'],
    moderator: ['read', 'write', 'delete'],
    user: ['read', 'write'],
    guest: ['read'],
  };
  
  return rolePermissions[user.role]?.includes(permission) ?? false;
}
```

### 6. Security Misconfiguration

#### Security Headers
```typescript
// next.config.js
const securityHeaders = [
  {
    key: 'Strict-Transport-Security',
    value: 'max-age=31536000; includeSubDomains',
  },
  {
    key: 'X-Content-Type-Options',
    value: 'nosniff',
  },
  {
    key: 'X-Frame-Options',
    value: 'DENY',
  },
  {
    key: 'X-XSS-Protection',
    value: '1; mode=block',
  },
  {
    key: 'Referrer-Policy',
    value: 'strict-origin-when-cross-origin',
  },
  {
    key: 'Content-Security-Policy',
    value: `
      default-src 'self';
      script-src 'self' 'unsafe-inline' https://www.googletagmanager.com;
      style-src 'self' 'unsafe-inline';
      img-src 'self' data: https:;
      font-src 'self' https://fonts.googleapis.com;
      connect-src 'self' https://www.google-analytics.com;
    `.replace(/\s+/g, ' '),
  },
];

/** @type {import('next').NextConfig} */
const nextConfig = {
  async headers() {
    return [
      {
        source: '/:path*',
        headers: securityHeaders,
      },
    ];
  },
};

module.exports = nextConfig;
```

### 7. Cross-Site Scripting (XSS)

```typescript
// ✅ CORRECT - Sanitize user input
import DOMPurify from 'isomorphic-dompurify';

function sanitizeHTML(dirtyHTML: string): string {
  return DOMPurify.sanitize(dirtyHTML);
}

// ✅ CORRECT - Use React's built-in escaping
function Comment({ text }: { text: string }) {
  return <div>{text}</div>; // Automatically escaped
}

// ❌ WRONG - Dangerous
function Comment({ text }: { text: string }) {
  return <div dangerouslySetInnerHTML={{ __html: text }} />;
}
```

### 8. Insecure Deserialization

```typescript
// ❌ WRONG - Vulnerable
const data = eval(jsonString); // NEVER use eval

// ✅ CORRECT - Use JSON parsing
const data = JSON.parse(jsonString);

// ✅ CORRECT - Validate schema
import { z } from 'zod';

const UserSchema = z.object({
  name: z.string(),
  email: z.string().email(),
  role: z.enum(['admin', 'user']),
});

const user = UserSchema.parse(data);
```

### 9. Using Components with Known Vulnerabilities

#### Keep Dependencies Updated
```bash
# Check for vulnerabilities
npm audit

# Fix automatically
npm audit fix

# Update packages
npm update

# Check outdated packages
npm outdated
```

#### Dependency Security
```json
// package.json
{
  "dependencies": {
    "next": "^16.2.10",
    "react": "^19.2.7"
  },
  "devDependencies": {
    "typescript": "^5"
  }
}
```

### 10. Insufficient Logging & Monitoring

#### Error Logging
```typescript
// ✅ CORRECT - Log errors appropriately
import * as Sentry from "@sentry/nextjs";

try {
  // Code
} catch (error) {
  Sentry.captureException(error);
  console.error('Error occurred:', error);
}
```

#### Request Logging
```typescript
// ✅ CORRECT - Log important events
function logEvent(
  level: 'info' | 'warn' | 'error',
  message: string,
  metadata?: Record<string, any>
) {
  console.log(JSON.stringify({
    timestamp: new Date().toISOString(),
    level,
    message,
    ...metadata,
  }));
}
```

---

## Implementation Checklist

### Development
- [ ] .env files in .gitignore
- [ ] No secrets in code
- [ ] Input validation on all forms
- [ ] Output encoding for user data
- [ ] HTTPS enforced
- [ ] Security headers configured
- [ ] CSRF protection enabled
- [ ] XSS protection enabled

### Testing
- [ ] Security headers verified
- [ ] OWASP ZAP scan passed
- [ ] Dependency audit clean
- [ ] Authentication flow tested
- [ ] Authorization tested
- [ ] Input validation tested
- [ ] Error handling tested

### Deployment
- [ ] Environment variables set
- [ ] Database backups configured
- [ ] SSL certificate valid
- [ ] WAF (Web Application Firewall) enabled
- [ ] DDoS protection enabled
- [ ] Monitoring alerts set
- [ ] Incident response plan documented

### Maintenance
- [ ] Weekly security updates
- [ ] Monthly dependency updates
- [ ] Quarterly security audit
- [ ] Annual penetration testing
- [ ] Security incident log

---

## Tools & Resources

### Security Scanning
- OWASP ZAP: https://www.zaproxy.org/
- Snyk: https://snyk.io/
- npm audit: Built-in vulnerability scanning
- Burp Suite Community: https://portswigger.net/burp/community

### Best Practices
- OWASP Top 10: https://owasp.org/www-project-top-ten/
- OWASP Cheat Sheet: https://cheatsheetseries.owasp.org/
- Node.js Security: https://nodejs.org/en/docs/guides/security/

### Monitoring & Logging
- Sentry: Error tracking https://sentry.io/
- LogRocket: Session replay https://logrocket.com/
- Datadog: Monitoring https://www.datadoghq.com/

---

## Response to Security Incidents

1. **Detect**: Monitor logs and alerts
2. **Contain**: Take affected systems offline if needed
3. **Investigate**: Determine scope and impact
4. **Remediate**: Fix vulnerability
5. **Document**: Log incident details
6. **Notify**: Inform affected users (if data breach)
7. **Learn**: Update processes to prevent recurrence

---

**Last Updated**: 2026-07-28
**Version**: 1.0
