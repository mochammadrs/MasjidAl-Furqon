<template>
  <section class="relative min-h-[600px] lg:min-h-[700px] flex items-center justify-center mb-28 md:mb-32">
    <!-- Background Gradient (Placeholder - akan diganti dengan foto masjid) -->
    <div class="absolute inset-0 z-0">
      <!-- Gradient Background -->
      <div class="absolute inset-0 bg-gradient-to-br from-masjid-dark via-[#3d2a1f] to-masjid-gold/40"></div>
      <!-- Pattern Overlay -->
      <div class="absolute inset-0 opacity-10" style="background-image: url('data:image/svg+xml,%3Csvg width=\'60\' height=\'60\' viewBox=\'0 0 60 60\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cg fill=\'none\' fill-rule=\'evenodd\'%3E%3Cg fill=\'%23ffffff\' fill-opacity=\'0.4\'%3E%3Cpath d=\'M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z\'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>
    </div>

    <!-- Content -->
    <div class="container mx-auto px-4 lg:px-8 relative z-20 py-20">
      <div class="text-center max-w-4xl mx-auto">
        <!-- Badge -->
        <div class="inline-block mb-6">
          <span class="inline-flex items-center gap-2 px-4 py-2 bg-masjid-gold/20 backdrop-blur-sm text-masjid-gold-light text-sm font-medium rounded-full border border-masjid-gold/30">
            <PhBuilding :size="16" />
            <span>Masjid Al-Furqon Tasikmalaya</span>
          </span>
        </div>

        <!-- Heading -->
        <h1 class="text-4xl md:text-5xl lg:text-6xl font-serif font-bold text-white mb-6 leading-tight">
          Selamat Datang di<br />
          <span class="text-masjid-gold">Masjid Al-Furqon</span>
        </h1>

        <!-- Subtitle -->
        <p class="text-lg md:text-xl text-gray-200 mb-8 max-w-2xl mx-auto">
          Membangun umat yang berakhlak mulia melalui pendidikan, dakwah, dan kepedulian sosial
        </p>

        <!-- CTA Buttons -->
        <div class="flex flex-wrap gap-4 justify-center">
          <a
            href="#jadwal-sholat"
            class="px-6 py-3 bg-masjid-gold hover:bg-masjid-gold/90 text-white font-medium rounded-lg transition-colors shadow-lg hover:shadow-xl"
          >
            Lihat Jadwal Sholat
          </a>
          <a
            href="#donasi"
            class="px-6 py-3 bg-white/10 backdrop-blur-sm hover:bg-white/20 text-white font-medium rounded-lg transition-colors border border-white/30"
          >
            Donasi Sekarang
          </a>
        </div>
      </div>
    </div>

    <!-- Overlay Stats Cards (Floating) -->
    <div class="absolute -bottom-20 left-0 right-0 z-30 hidden md:block">
      <div class="container mx-auto px-4 lg:px-8">
        <div class="grid grid-cols-2 lg:grid-cols-4 gap-4">
          <div
            v-for="(stat, index) in stats"
            :key="index"
            class="bg-white/90 backdrop-blur-lg rounded-xl p-6 shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-1 border border-masjid-gold/20"
          >
            <div class="flex items-center gap-4">
              <component :is="stat.icon" :size="40" class="text-masjid-gold flex-shrink-0" />
              <div class="flex-1">
                <div class="text-3xl font-serif font-bold text-masjid-dark mb-1">
                  {{ stat.value }}
                </div>
                <div class="text-sm text-masjid-text-muted">
                  {{ stat.label }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Mobile Stats -->
    <div class="absolute -bottom-16 left-0 right-0 z-30 md:hidden">
      <div class="container mx-auto px-4">
        <div class="grid grid-cols-2 gap-3">
          <div
            v-for="(stat, index) in stats"
            :key="index"
            class="bg-white/95 backdrop-blur-lg rounded-lg p-4 shadow-lg border border-masjid-gold/20"
          >
            <component :is="stat.icon" :size="24" class="text-masjid-gold mb-1" />
            <div class="text-xl font-serif font-bold text-masjid-dark">
              {{ stat.value }}
            </div>
            <div class="text-xs text-masjid-text-muted">
              {{ stat.label }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { PhBook, PhUsers, PhGraduationCap, PhHeart, PhBuilding } from '@phosphor-icons/vue'

const stats = [
  {
    icon: PhBook,
    value: '20+',
    label: 'Kajian Rutin'
  },
  {
    icon: PhUsers,
    value: '800+',
    label: 'Jamaah Aktif'
  },
  {
    icon: PhGraduationCap,
    value: '150+',
    label: 'Santri TPA'
  },
  {
    icon: PhHeart,
    value: '30+',
    label: 'Program Sosial'
  }
]
</script>
