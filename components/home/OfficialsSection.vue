<template>
  <section id="pengurus" class="py-20 md:py-28 bg-gradient-to-b from-white via-masjid-cream/30 to-white">
    <div class="container mx-auto px-6">
      <!-- Section Header -->
      <div class="text-center max-w-3xl mx-auto mb-16">
        <div class="inline-flex items-center gap-2 px-4 py-2 bg-white border border-masjid-gold/20 rounded-full mb-5 shadow-sm">
          <PhUsers :size="18" class="text-masjid-gold" />
          <span class="text-sm font-semibold text-masjid-dark tracking-wide">Pengurus Masjid</span>
        </div>
        <h2 class="text-3xl md:text-4xl lg:text-5xl font-serif font-bold text-masjid-dark mb-4 leading-tight">
          Pengurus Masjid
        </h2>
        <p class="text-lg text-masjid-text-muted leading-relaxed">
          Kenali para pengurus yang mengabdi untuk kemakmuran Masjid Al-Furqon
        </p>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
        <SkeletonOfficialCardSkeleton v-for="i in 4" :key="i" />
      </div>

      <!-- Empty State -->
      <div v-else-if="officials.length === 0" class="text-center py-16">
        <div class="inline-flex items-center justify-center w-24 h-24 rounded-2xl bg-gray-100 mb-6">
          <PhUsers :size="48" class="text-gray-400" />
        </div>
        <p class="text-lg text-masjid-text-muted">Belum ada data pengurus</p>
      </div>

      <!-- Officials Grid -->
      <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-7">
        <div
          v-for="official in officials"
          :key="official.id"
          class="group bg-white rounded-2xl border border-gray-100 hover:border-masjid-gold/40 hover:shadow-2xl transition-all duration-500 overflow-hidden"
        >
          <!-- Photo -->
          <div class="relative aspect-square overflow-hidden bg-gradient-to-br from-masjid-gold/20 via-masjid-cream to-masjid-gold/10">
            <img
              v-if="official.photo_url"
              :src="official.photo_url"
              :alt="official.name"
              class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700"
              loading="lazy"
              decoding="async"
            />
            <div v-else class="w-full h-full flex items-center justify-center">
              <PhUser :size="80" class="text-masjid-gold/30" />
            </div>
          </div>

          <!-- Info -->
          <div class="p-6 text-center">
            <h3 class="text-lg font-serif font-bold text-masjid-dark mb-1 group-hover:text-masjid-gold transition-colors">
              {{ official.name }}
            </h3>
            <p class="text-sm text-masjid-gold font-semibold mb-4">
              {{ official.position }}
            </p>

            <!-- Contact Info -->
            <div v-if="official.phone || official.email" class="space-y-2 mb-4 border-t border-gray-100 pt-4">
              <a
                v-if="official.phone"
                :href="`tel:${official.phone}`"
                class="flex items-center justify-center gap-2 text-xs text-masjid-text-muted hover:text-masjid-gold transition-colors"
              >
                <PhPhone :size="14" class="flex-shrink-0" />
                <span>{{ official.phone }}</span>
              </a>
              <a
                v-if="official.email"
                :href="`mailto:${official.email}`"
                class="flex items-center justify-center gap-2 text-xs text-masjid-text-muted hover:text-masjid-gold transition-colors"
              >
                <PhEnvelope :size="14" class="flex-shrink-0" />
                <span class="truncate">{{ official.email }}</span>
              </a>
            </div>

            <!-- Bio -->
            <p
              v-if="official.bio"
              class="text-xs text-masjid-text-muted line-clamp-3 leading-relaxed"
            >
              {{ official.bio }}
            </p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { PhUsers, PhUser, PhPhone, PhEnvelope } from '@phosphor-icons/vue'

const { fetchOfficials } = useOfficials()

const officials = ref<any[]>([])
const loading = ref(true)

const loadOfficials = async () => {
  loading.value = true
  try {
    const data = await fetchOfficials(false) // Only active officials
    officials.value = data || []
  } catch (error) {
    console.error('Error loading officials:', error)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  loadOfficials()
})
</script>

<style scoped>
.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
