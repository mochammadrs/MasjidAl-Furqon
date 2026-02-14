<template>
  <div class="min-h-screen flex items-center justify-center bg-gradient-to-b from-masjid-cream to-white px-4 py-12">
    <div class="max-w-3xl w-full">
      <!-- 404 Illustration -->
      <div class="text-center mb-12">
        <div class="inline-flex items-center justify-center w-24 h-24 bg-masjid-gold/10 rounded-full mb-6 animate-bounce">
          <PhBuilding :size="48" class="text-masjid-gold" />
        </div>
        <h1 class="text-7xl md:text-8xl font-bold text-masjid-gold mb-4">404</h1>
        <h2 class="text-2xl md:text-3xl font-serif font-bold text-masjid-dark mb-3">
          Halaman Tidak Ditemukan
        </h2>
        <p class="text-base md:text-lg text-masjid-text-muted max-w-md mx-auto">
          Maaf, halaman yang Anda cari tidak ada atau telah dipindahkan.
        </p>
      </div>

      <!-- Quick Links -->
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-8">
        <NuxtLink
          to="/"
          class="flex items-center gap-3 p-4 bg-white rounded-xl shadow-md hover:shadow-lg transition-all group border border-masjid-border"
        >
          <div class="w-12 h-12 bg-masjid-gold/10 rounded-lg flex items-center justify-center group-hover:bg-masjid-gold group-hover:scale-110 transition-all">
            <svg class="w-6 h-6 text-masjid-gold group-hover:text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
            </svg>
          </div>
          <div class="text-left">
            <div class="font-semibold text-masjid-dark">Beranda</div>
            <div class="text-sm text-masjid-text-muted">Kembali ke halaman utama</div>
          </div>
        </NuxtLink>

        <NuxtLink
          to="/#kegiatan"
          class="flex items-center gap-3 p-4 bg-white rounded-xl shadow-md hover:shadow-lg transition-all group border border-masjid-border"
        >
          <div class="w-12 h-12 bg-masjid-gold/10 rounded-lg flex items-center justify-center group-hover:bg-masjid-gold group-hover:scale-110 transition-all">
            <svg class="w-6 h-6 text-masjid-gold group-hover:text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
            </svg>
          </div>
          <div class="text-left">
            <div class="font-semibold text-masjid-dark">Kegiatan</div>
            <div class="text-sm text-masjid-text-muted">Lihat jadwal kajian</div>
          </div>
        </NuxtLink>

        <NuxtLink
          to="/#donasi"
          class="flex items-center gap-3 p-4 bg-white rounded-xl shadow-md hover:shadow-lg transition-all group border border-masjid-border"
        >
          <div class="w-12 h-12 bg-masjid-gold/10 rounded-lg flex items-center justify-center group-hover:bg-masjid-gold group-hover:scale-110 transition-all">
            <svg class="w-6 h-6 text-masjid-gold group-hover:text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
          </div>
          <div class="text-left">
            <div class="font-semibold text-masjid-dark">Donasi</div>
            <div class="text-sm text-masjid-text-muted">Berkontribusi untuk masjid</div>
          </div>
        </NuxtLink>

        <a
          href="https://wa.me/6281234567890"
          target="_blank"
          rel="noopener noreferrer"
          class="flex items-center gap-3 p-4 bg-white rounded-xl shadow-md hover:shadow-lg transition-all group border border-masjid-border"
        >
          <div class="w-12 h-12 bg-masjid-gold/10 rounded-lg flex items-center justify-center group-hover:bg-masjid-gold group-hover:scale-110 transition-all">
            <svg class="w-6 h-6 text-masjid-gold group-hover:text-white" fill="currentColor" viewBox="0 0 24 24">
              <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
            </svg>
          </div>
          <div class="text-left">
            <div class="font-semibold text-masjid-dark">WhatsApp</div>
            <div class="text-sm text-masjid-text-muted">Hubungi kami</div>
          </div>
        </a>
      </div>

      <!-- Back Button -->
      <div class="flex gap-4 justify-center">
        <button
          @click="$router.back()"
          class="px-6 py-3 bg-gray-100 hover:bg-gray-200 text-masjid-dark font-medium rounded-lg transition-colors flex items-center gap-2"
        >
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
          </svg>
          Kembali
        </button>
        <NuxtLink
          to="/"
          class="px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-colors"
        >
          Ke Beranda
        </NuxtLink>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PhBuilding } from '@phosphor-icons/vue'

// Set meta for 404 page
useSeoMeta({
  title: '404 - Halaman Tidak Ditemukan | Masjid Al-Furqon',
  robots: 'noindex, nofollow'
})
</script>
