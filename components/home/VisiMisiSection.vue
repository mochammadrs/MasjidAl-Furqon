<template>
  <section id="tentang" class="py-20 bg-gradient-to-b from-white to-masjid-cream">
    <div class="container mx-auto px-6">
      <!-- Section Header -->
      <div class="text-center max-w-2xl mx-auto mb-16">
        <div class="inline-flex items-center gap-2 px-5 py-2.5 bg-gradient-to-r from-masjid-gold/10 to-masjid-dark/10 border border-masjid-gold/30 rounded-full mb-6 shadow-sm">
          <svg class="w-5 h-5 text-masjid-gold" fill="currentColor" viewBox="0 0 24 24">
            <path d="M12 2L2 7v10c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V7l-10-5z"/>
          </svg>
          <span class="text-sm font-semibold text-masjid-dark tracking-wide">Tentang Kami</span>
        </div>
        <h2 class="text-4xl md:text-5xl font-serif font-bold text-masjid-dark mb-4 leading-tight">
          Visi & Misi
        </h2>
        <p class="text-lg text-masjid-text-muted leading-relaxed">
          Membangun umat yang berakhlak mulia melalui pendidikan dan dakwah
        </p>
      </div>

      <div class="max-w-6xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-8">
        <!-- Visi Card -->
        <div class="bg-white rounded-2xl shadow-xl border border-masjid-border p-8 hover:shadow-2xl hover:border-masjid-gold/50 transition-all duration-300 hover:-translate-y-2">
          <div class="flex items-center gap-4 mb-6">
            <div class="w-16 h-16 bg-gradient-to-br from-masjid-gold to-masjid-dark rounded-xl flex items-center justify-center flex-shrink-0 shadow-lg">
              <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
              </svg>
            </div>
            <div>
              <h3 class="text-2xl font-serif font-bold text-masjid-dark">
                Visi Masjid
              </h3>
              <div class="h-1 w-16 bg-gradient-to-r from-masjid-gold to-masjid-dark rounded-full mt-2"></div>
            </div>
          </div>

          <div v-if="loading" class="flex justify-center py-8">
            <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-masjid-gold"></div>
          </div>

          <div v-else class="prose prose-lg max-w-none">
            <p class="text-masjid-text-muted leading-relaxed whitespace-pre-line">
              {{ visi || defaultVisi }}
            </p>
          </div>
        </div>

        <!-- Misi Card -->
        <div class="bg-white rounded-2xl shadow-xl border border-masjid-border p-8 hover:shadow-2xl hover:border-masjid-gold/50 transition-all duration-300 hover:-translate-y-2">
          <div class="flex items-center gap-4 mb-6">
            <div class="w-16 h-16 bg-gradient-to-br from-masjid-gold to-masjid-dark rounded-xl flex items-center justify-center flex-shrink-0 shadow-lg">
              <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
            <div>
              <h3 class="text-2xl font-serif font-bold text-masjid-dark">
                Misi Masjid
              </h3>
              <div class="h-1 w-16 bg-gradient-to-r from-masjid-gold to-masjid-dark rounded-full mt-2"></div>
            </div>
          </div>

          <div v-if="loading" class="flex justify-center py-8">
            <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-masjid-gold"></div>
          </div>

          <div v-else class="space-y-4">
            <div
              v-for="(item, index) in misiList"
              :key="index"
              class="flex items-start gap-3 group"
            >
              <div class="flex-shrink-0 w-8 h-8 bg-masjid-gold/10 rounded-full flex items-center justify-center group-hover:bg-masjid-gold group-hover:scale-110 transition-all">
                <span class="text-sm font-bold text-masjid-gold group-hover:text-white">{{ index + 1 }}</span>
              </div>
              <p class="text-masjid-text-muted leading-relaxed flex-1 pt-0.5">
                {{ item }}
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Additional Info -->
      <div class="mt-12 max-w-4xl mx-auto">
        <div class="bg-gradient-to-r from-masjid-gold/10 via-masjid-cream to-masjid-gold/10 rounded-2xl p-8 border border-masjid-gold/20">
          <div class="text-center">
            <p class="text-masjid-dark text-lg font-medium mb-2">
              "Sesungguhnya masjid-masjid Allah itu dimakmurkan oleh orang yang beriman kepada Allah dan hari akhir"
            </p>
            <p class="text-masjid-text-muted text-sm">
              (QS. At-Taubah: 18)
            </p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const { fetchSettingsObject } = useSettings()

const loading = ref(true)
const visi = ref('')
const misi = ref('')

// Default content (akan diganti oleh admin)
const defaultVisi = `Menjadi masjid yang maju, mandiri, dan berkontribusi dalam pembinaan umat yang berakhlakul karimah, berilmu, dan peduli terhadap sesama.`

const defaultMisi = `Menyelenggarakan kegiatan dakwah dan pendidikan Islam yang berkualitas
Membina generasi Qurani melalui program tahfizh dan kajian rutin
Mengembangkan ekonomi umat melalui program sosial dan pemberdayaan
Membangun ukhuwah Islamiyah dan kepedulian sosial
Mengelola masjid secara transparan, amanah, dan profesional`

const misiList = computed(() => {
  const misiText = misi.value || defaultMisi
  return misiText.split('\n').filter(item => item.trim())
})

const loadVisiMisi = async () => {
  loading.value = true
  try {
    const settings = await fetchSettingsObject()
    
    if (settings.masjid_visi) {
      visi.value = settings.masjid_visi
    }
    if (settings.masjid_misi) {
      misi.value = settings.masjid_misi
    }
  } catch (error) {
    console.error('Error loading visi misi:', error)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  loadVisiMisi()
})
</script>
