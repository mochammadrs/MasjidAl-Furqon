// Auto-generated sitemap.xml untuk SEO
// Endpoint: /sitemap.xml

export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig()
  const baseUrl = 'https://masjid-alfurqon.com' // Update dengan domain production

  // Daftar route statis
  const staticRoutes = [
    { url: '/', priority: '1.0', changefreq: 'daily' },
    { url: '/#kegiatan', priority: '0.9', changefreq: 'daily' },
    { url: '/#visi-misi', priority: '0.8', changefreq: 'weekly' },
    { url: '/#pengurus', priority: '0.8', changefreq: 'monthly' },
    { url: '/#galeri', priority: '0.8', changefreq: 'weekly' },
    { url: '/#donasi', priority: '0.9', changefreq: 'daily' }
  ]

  // Generate XML
  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:news="http://www.google.com/schemas/sitemap-news/0.9"
        xmlns:xhtml="http://www.w3.org/1999/xhtml"
        xmlns:mobile="http://www.google.com/schemas/sitemap-mobile/1.0"
        xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">
${staticRoutes
  .map(
    (route) => `  <url>
    <loc>${baseUrl}${route.url}</loc>
    <changefreq>${route.changefreq}</changefreq>
    <priority>${route.priority}</priority>
    <lastmod>${new Date().toISOString()}</lastmod>
  </url>`
  )
  .join('\n')}
</urlset>`

  setHeader(event, 'Content-Type', 'application/xml')
  setHeader(event, 'Cache-Control', 'public, max-age=86400') // Cache 24 jam
  
  return sitemap
})
