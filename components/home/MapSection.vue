<template>
  <section id="lokasi" class="py-20 md:py=28 bg-white">
    <div class="container mx-auto px-6">
      <!-- Section Header -->
      <div class="text-center max-w-3xl mx-auto mb-16">
        <div class="inline-flex items-center gap-2 px-4 py-2 bg-white border border-masjid-gold/20 rounded-full mb-5 shadow-sm">
          <PhMapPin :size="18" class="text-masjid-gold" />
          <span class="text-sm font-semibold text-masjid-dark tracking-wide">Lokasi Masjid</span>
        </div>
        <h2 class="text-3xl md:text-4xl lg:text-5xl font-serif font-bold text-masjid-dark mb-4 leading-tight">
          Kunjungi Kami
        </h2>
        <p class="text-lg text-masjid-text-muted leading-relaxed">
          Temukan lokasi Masjid Jamie Al-Furqon di Perumahan Bukit Rancapaku Indah, Tasikmalaya
        </p>
      </div>

      <div class="max-w-6xl mx-auto">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <!-- Address Info Card -->
          <div class="lg:col-span-1 space-y-6">
            <!-- Address -->
            <div class="bg-gradient-to-br from-masjid-gold/10 to-masjid-cream rounded-2xl p-6 border border-masjid-gold/20">
              <div class="flex items-start gap-4">
                <div class="w-12 h-12 bg-masjid-gold rounded-xl flex items-center justify-center flex-shrink-0 shadow-lg">
                  <PhMapPin :size="24" class="text-white" />
                </div>
                <div class="flex-1">
                  <h3 class="text-lg font-serif font-bold text-masjid-dark mb-2">
                    Alamat Lengkap
                  </h3>
                  <p class="text-sm text-masjid-text-muted leading-relaxed">
                    M49P+XMF, Perumahan Bukit Rancapaku Indah<br />
                    Tasikmalaya Regency, West Java 46466
                  </p>
                </div>
              </div>
            </div>

            <!-- Coordinates -->
            <div class="bg-white rounded-2xl p-6 border border-gray-200 shadow-sm">
              <div class="flex items-start gap-4">
                <div class="w-12 h-12 bg-blue-500 rounded-xl flex items-center justify-center flex-shrink-0">
                  <PhCompass :size="24" class="text-white" />
                </div>
                <div class="flex-1">
                  <h3 class="text-lg font-serif font-bold text-masjid-dark mb-2">
                    Koordinat GPS
                  </h3>
                  <p class="text-sm text-masjid-text-muted font-mono">
                    -7.329959, 108.136563
                  </p>
                </div>
              </div>
            </div>

            <!-- Directions Button -->
            <a
              :href="googleMapsUrl"
              target="_blank"
              rel="noopener noreferrer"
              class="flex items-center justify-center gap-3 w-full px-6 py-4 bg-masjid-gold hover:bg-masjid-dark text-white font-semibold rounded-xl transition-all duration-300 shadow-lg hover:shadow-xl group"
            >
              <PhNavigationArrow :size="20" class="group-hover:rotate-45 transition-transform duration-300" />
              <span>Petunjuk Arah di Google Maps</span>
            </a>
          </div>

          <!-- Map Embed -->
          <div class="lg:col-span-2">
            <div class="relative rounded-2xl overflow-hidden shadow-2xl border border-gray-200 h-[400px] lg:h-[500px]">
              <iframe
                :src="googleMapsEmbedUrl"
                width="100%"
                height="100%"
                style="border:0;"
                allowfullscreen
                loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"
                class="w-full h-full"
              ></iframe>
            </div>
          </div>
        </div>

        <!-- Transport Tips -->
        <div class="mt-12 grid grid-cols-1 md:grid-cols-3 gap-6">
          <div class="bg-white rounded-xl p-6 border border-gray-200 hover:border-masjid-gold/30 hover:shadow-lg transition-all">
            <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center mb-4">
              <PhCar :size="20" class="text-green-600" />
            </div>
            <h4 class="font-semibold text-masjid-dark mb-2">Kendaraan Pribadi</h4>
            <p class="text-sm text-masjid-text-muted">Tersedia area parkir yang luas untuk jamaah</p>
          </div>

          <div class="bg-white rounded-xl p-6 border border-gray-200 hover:border-masjid-gold/30 hover:shadow-lg transition-all">
            <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mb-4">
              <PhBus :size="20" class="text-blue-600" />
            </div>
            <h4 class="font-semibold text-masjid-dark mb-2">Angkutan Umum</h4>
            <p class="text-sm text-masjid-text-muted">Akses mudah dengan ojek online</p>
          </div>

          <div class="bg-white rounded-xl p-6 border border-gray-200 hover:border-masjid-gold/30 hover:shadow-lg transition-all">
            <div class="w-10 h-10 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
              <PhClock :size="20" class="text-orange-600" />
            </div>
            <h4 class="font-semibold text-masjid-dark mb-2">Waktu Kunjungan</h4>
            <p class="text-sm text-masjid-text-muted">Buka setiap hari, 24 jam untuk ibadah</p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { PhMapPin, PhCompass, PhNavigationArrow, PhCar, PhBus, PhClock } from '@phosphor-icons/vue'

const latitude = -7.329959122263225
const longitude = 108.13656343610029

// Google Maps directions URL
const googleMapsUrl = computed(() => {
  return `https://www.google.com/maps/dir/?api=1&destination=${latitude},${longitude}`
})

// Google Maps embed URL
const googleMapsEmbedUrl = computed(() => {
  return `https://www.google.com/maps/embed/v1/place?key=AIzaSyBFw0Qbyq9zTFTd-tUY6dZWTgaQzuU17R8&q=${latitude},${longitude}&zoom=15`
})
</script>
