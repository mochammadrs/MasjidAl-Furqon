<template>
  <button
    @click="sharePrayerTimes"
    class="inline-flex items-center gap-2 px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-all shadow-md hover:shadow-lg"
  >
    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z"/>
    </svg>
    <span>Bagikan Jadwal Sholat</span>
  </button>
</template>

<script setup lang="ts">
interface PrayerTime {
  name: string
  time: string
  isNext: boolean
}

interface Props {
  prayerTimes: PrayerTime[]
}

const props = defineProps<Props>()

const sharePrayerTimes = async () => {
  const now = new Date()
  const dateStr = now.toLocaleDateString('id-ID', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })

  const text = `Jadwal Sholat Tasikmalaya\n${dateStr}\n\n${props.prayerTimes
    .map(p => `${p.name}: ${p.time}`)
    .join('\n')}\n\nMasjid Al-Furqon\nMembangun Umat Berakhlak Mulia`

  // Check if native share is supported
  if (navigator.share) {
    try {
      await navigator.share({
        title: 'Jadwal Sholat Tasikmalaya',
        text: text
      })
    } catch (err) {
      // User cancelled or error occurred
      if ((err as Error).name !== 'AbortError') {
        copyToClipboard(text)
      }
    }
  } else {
    // Fallback to clipboard
    copyToClipboard(text)
  }
}

const copyToClipboard = async (text: string) => {
  try {
    await navigator.clipboard.writeText(text)
    alert('✅ Jadwal sholat berhasil disalin ke clipboard!')
  } catch (err) {
    alert('❌ Gagal menyalin jadwal sholat')
  }
}
</script>
