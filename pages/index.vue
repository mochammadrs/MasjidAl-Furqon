<template>
  <div>
    <LayoutNavbar />
    <main class="min-h-screen">
      <HomeHeroSection />
      <PrayerWidget />
      <HomeVisiMisiSection />
      <HomeActivitiesSection />
      <HomeDonationRow />
      <HomeOfficialsSection />
      <HomeGallerySection />
    </main>
    <LayoutAppFooter />
    <LayoutWhatsAppButton />
  </div>
</template>

<script setup lang="ts">
// Explicit import untuk Prayer Widget
import PrayerWidget from '~/components/prayer/PrayerWidget.vue'

const { fetchSettingsObject } = useSettings()

// Fetch settings untuk dynamic meta
const settings = ref<Record<string, string>>({})

const loadSettings = async () => {
  try {
    settings.value = await fetchSettingsObject()
  } catch (error) {
    console.error('Error loading settings for meta:', error)
  }
}

await loadSettings()

// Dynamic SEO Meta Tags
const siteName = settings.value.masjid_name || 'Masjid Al-Furqon'
const siteAddress = settings.value.masjid_address || 'Tasikmalaya, Jawa Barat'

useSeoMeta({
  title: `${siteName} - Membangun Umat Berakhlak Mulia`,
  description: `Website resmi ${siteName} ${siteAddress}. Informasi jadwal sholat, kegiatan kajian, donasi, dan program dakwah Islam.`,
  
  // Open Graph (Facebook, WhatsApp, LinkedIn)
  ogTitle: siteName,
  ogDescription: 'Membangun umat yang berakhlak mulia melalui pendidikan, dakwah, dan kepedulian sosial',
  ogImage: '/og-image.jpg',
  ogImageAlt: `Logo ${siteName}`,
  ogType: 'website',
  ogUrl: 'https://masjid-alfurqon.com',
  ogLocale: 'id_ID',
  ogSiteName: siteName,
  
  // Twitter Card
  twitterCard: 'summary_large_image',
  twitterTitle: siteName,
  twitterDescription: 'Membangun umat yang berakhlak mulia melalui pendidikan, dakwah, dan kepedulian sosial',
  twitterImage: '/og-image.jpg',
  twitterImageAlt: `Logo ${siteName}`,
  
  // Additional SEO
  keywords: 'masjid, tasikmalaya, kajian islam, donasi, tahfizh, dakwah, jadwal sholat, kegiatan masjid',
  author: siteName,
  robots: 'index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1',
  
  // Mobile
  viewport: 'width=device-width, initial-scale=1, maximum-scale=5',
  themeColor: '#C6A87C'
})

// Structured Data (JSON-LD) untuk Google Rich Results
useHead({
  script: [
    {
      type: 'application/ld+json',
      innerHTML: JSON.stringify({
        '@context': 'https://schema.org',
        '@type': 'Mosque',
        name: siteName,
        description: 'Masjid yang fokus pada pendidikan, dakwah, dan kepedulian sosial',
        address: {
          '@type': 'PostalAddress',
          addressLocality: 'Tasikmalaya',
          addressRegion: 'Jawa Barat',
          addressCountry: 'ID',
          streetAddress: siteAddress
        },
        url: 'https://masjid-alfurqon.com',
        telephone: settings.value.whatsapp_number || '6281234567890',
        email: settings.value.masjid_email || 'masjid@alfurqon.com',
        image: '/og-image.jpg',
        logo: '/images/logo-masjid.png',
        openingHours: 'Mo-Su 03:30-22:00',
        priceRange: 'Free',
        sameAs: [
          'https://instagram.com/masjidalfurqon'
        ]
      })
    }
  ],
  link: [
    { rel: 'canonical', href: 'https://masjid-alfurqon.com' }
  ]
})
</script>
