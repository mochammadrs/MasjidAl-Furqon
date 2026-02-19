<template>
  <section id="jadwal-sholat" class="py-16 md:py-20">
    <div class="container mx-auto px-4 lg:px-8">
      <!-- Section Header -->
      <div class="text-center mb-12">
        <div class="inline-flex items-center gap-2 px-4 py-2 bg-masjid-gold-light rounded-full mb-4">
          <PhBuilding :size="16" class="text-masjid-dark" />
          <span class="text-sm font-medium text-masjid-dark">Jadwal Sholat Hari Ini</span>
        </div>
        <!-- Date Info -->
        <div class="text-masjid-text-muted mb-2">
          <span class="font-medium">{{ currentDate }}</span>
        </div>
        <h2 class="text-3xl md:text-4xl font-serif font-bold text-masjid-dark mb-3">
          Waktu Sholat Tasikmalaya
        </h2>
        <p class="text-masjid-text-muted">
          Sholat berikutnya: <span class="font-semibold text-masjid-gold">{{ nextPrayer }}</span>
          <span v-if="countdown" class="ml-2">dalam {{ countdown }}</span>
        </p>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="flex justify-center items-center py-12">
        <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-masjid-gold"></div>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="text-center py-12">
        <div class="bg-red-50 border border-red-200 rounded-lg p-6 max-w-md mx-auto">
          <div class="inline-flex items-center gap-2 text-red-600 mb-3">
            <PhWarning :size="20" />
            <span>Gagal memuat jadwal sholat</span>
          </div>
          <button
            @click="refetch"
            class="px-4 py-2 bg-masjid-gold text-white rounded-lg text-sm hover:bg-masjid-dark transition-colors"
          >
            Coba Lagi
          </button>
        </div>
      </div>

      <!-- Prayer Times Grid -->
      <div v-else class="grid grid-cols-2 md:grid-cols-5 gap-4 max-w-6xl mx-auto">
        <div
          v-for="prayer in prayerTimes"
          :key="prayer.name"
          :class="[
            'relative rounded-xl p-6 transition-all duration-300 hover:scale-105',
            prayer.isNext
              ? 'bg-white border-2 border-masjid-gold shadow-xl shadow-masjid-gold/20'
              : 'bg-white/50 border border-masjid-border hover:bg-white'
          ]"
        >
          <!-- Next Prayer Badge -->
          <div
            v-if="prayer.isNext"
            class="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 bg-masjid-gold text-white text-xs font-medium rounded-full shadow-lg"
          >
            Selanjutnya
          </div>

          <!-- Prayer Name -->
          <div class="text-center">
            <h3
              :class="[
                'text-lg md:text-xl font-serif font-bold mb-3',
                prayer.isNext ? 'text-masjid-dark' : 'text-masjid-text-muted'
              ]"
            >
              {{ prayer.name }}
            </h3>

            <!-- Time -->
            <div
              :class="[
                'text-2xl md:text-3xl font-bold font-sans mb-1',
                prayer.isNext ? 'text-masjid-gold' : 'text-masjid-dark'
              ]"
            >
              {{ prayer.time }}
            </div>

            <!-- WIB Label -->
            <div class="text-xs text-masjid-text-muted">
              WIB
            </div>
          </div>

          <!-- Pulse Animation for Next Prayer -->
          <div
            v-if="prayer.isNext"
            class="absolute inset-0 rounded-xl border-2 border-masjid-gold animate-ping opacity-20 pointer-events-none"
          ></div>
        </div>
      </div>

      <!-- Share Button -->
      <div class="text-center mt-8">
        <button
          @click="shareSchedule"
          class="inline-flex items-center gap-2 px-5 py-2.5 bg-masjid-gold/10 hover:bg-masjid-gold/20 text-masjid-dark rounded-lg transition-colors border border-masjid-gold/30"
        >
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z"/>
          </svg>
          <span class="font-medium">Bagikan Jadwal</span>
        </button>
      </div>

      <!-- Location Info -->
      <div class="flex items-center justify-center gap-2 mt-6 text-sm text-masjid-text-muted">
        <PhMapPin :size="16" />
        <span>Tasikmalaya, Jawa Barat</span>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { PhWarning, PhBuilding, PhMapPin } from '@phosphor-icons/vue'

const {
  prayerTimes,
  nextPrayer,
  countdown,
  loading,
  error,
  refetch
} = usePrayerTimes()

// Current date in Indonesian format
const currentDate = computed(() => {
  const now = new Date()
  const days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu']
  const months = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ]
  
  const dayName = days[now.getDay()]
  const date = now.getDate()
  const monthName = months[now.getMonth()]
  const year = now.getFullYear()
  
  return `${dayName}, ${date} ${monthName} ${year}`
})

const shareSchedule = () => {
  const text = `Jadwal Sholat Hari Ini - Masjid Jamie Al-Furqon Tasikmalaya\n\n${prayerTimes.value.map(p => `${p.name}: ${p.time}`).join('\n')}\n\nSholat berikutnya: ${nextPrayer.value}`
  
  if (navigator.share) {
    navigator.share({
      title: 'Jadwal Sholat - Masjid Jamie Al-Furqon',
      text: text
    }).catch(() => {
      // Fallback to clipboard
      copyToClipboard(text)
    })
  } else {
    copyToClipboard(text)
  }
}

const copyToClipboard = (text: string) => {
  navigator.clipboard.writeText(text).then(() => {
    alert('Jadwal sholat berhasil disalin!')
  })
}
</script>
