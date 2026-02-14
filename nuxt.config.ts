// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },

  modules: [
    '@nuxtjs/tailwindcss',
    '@pinia/nuxt',
    '@nuxtjs/google-fonts'
  ],

  googleFonts: {
    families: {
      'Playfair Display': [400, 500, 600, 700],
      'Plus Jakarta Sans': [300, 400, 500, 600, 700]
    },
    display: 'swap',
    preload: true,
    prefetch: true,
    preconnect: true,
    download: true
  },

  app: {
    head: {
      title: 'Masjid Al-Furqon - Membangun Umat Berakhlak Mulia',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'description', content: 'Website resmi Masjid Al-Furqon Tasikmalaya. Informasi jadwal sholat, kegiatan kajian, dan program dakwah.' },
        { property: 'og:title', content: 'Masjid Al-Furqon' },
        { property: 'og:type', content: 'website' }
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
      ]
    }
  },

  runtimeConfig: {
    public: {
      supabaseUrl: process.env.SUPABASE_URL || '',
      supabaseKey: process.env.SUPABASE_ANON_KEY || ''
    }
  },

  // Performance & Build Optimizations
  experimental: {
    payloadExtraction: true,
    componentIslands: true
  },

  nitro: {
    compressPublicAssets: true,
    minify: true
  },

  vite: {
    build: {
      rollupOptions: {
        output: {
          manualChunks: {
            // Separate admin pages into their own chunk
            admin: [
              './pages/admin/dashboard.vue',
              './pages/admin/activities/index.vue',
              './pages/admin/officials/index.vue',
              './pages/admin/gallery/index.vue',
              './pages/admin/settings.vue'
            ]
          }
        }
      }
    }
  },

  routeRules: {
    // Homepage: SSR for better SEO, but no prerender to avoid build-time API calls
    '/': { ssr: true },
    // Admin pages: no prerender, client-side only
    '/admin/**': { ssr: false },
    // API routes
    '/api/**': { cors: true }
  }
})
