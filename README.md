# FP&A Monthly Close App — Hosted

This repo hosts a single-file app (`index.html`) via **GitHub Pages**.

## URL
After the first deployment, your site will be available at the Pages environment URL shown in Actions.
Typical format: `https://<org-or-user>.github.io/<repo>/`

## Quick Start
```bash
bash scripts/setup_github_pages.sh fpa-close-app private
```

* (Optional custom domain): `bash scripts/setup_github_pages.sh fpa-close-app private fpa-close.example.com`

## Verify

* ✅ HTTPS loads `index.html`
* ✅ No extra network calls (DevTools → Network tab stays empty after load)
* ✅ `404.html` redirects to root for deep links
* ✅ Updates deploy on push to `main` (see Actions → Deploy to GitHub Pages)

## Custom Domain (optional)

1. Add `CNAME` file with your domain (already automated if passed to setup script).
2. Create a DNS `CNAME` to `<org-or-user>.github.io`.
3. In repo → Settings → Pages, verify domain and enforce HTTPS.

## Notes

* Pages is static hosting; headers are limited. For custom headers, use Cloudflare or S3+CloudFront.
* App runs entirely client-side with no network dependencies after initial load.
* Demo mode works offline with embedded datasets.
