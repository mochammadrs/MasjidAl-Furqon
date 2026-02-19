<template>
  <section class="relative min-h-[600px] lg:min-h-[700px] flex items-center justify-center mb-36 md:mb-32">
    <!-- Premium Background with Animated Elements -->
    <div class="absolute inset-0 z-0 overflow-hidden">
      <!-- Base Gradient Mesh -->
      <div class="absolute inset-0 bg-gradient-to-br from-masjid-dark via-[#2d1f16] to-[#4a3326]"></div>
      
      <!-- Animated Ambient Glows -->
      <div class="absolute top-1/4 -left-32 w-96 h-96 bg-masjid-gold/30 rounded-full blur-3xl animate-pulse-slow opacity-40"></div>
      <div class="absolute top-1/3 -right-32 w-80 h-80 bg-masjid-cream/20 rounded-full blur-3xl animate-float opacity-30" style="animation-delay: 1s;"></div>
      <div class="absolute bottom-1/4 left-1/4 w-72 h-72 bg-amber-600/20 rounded-full blur-3xl animate-float-slow opacity-25" style="animation-delay: 2s;"></div>
      <div class="absolute top-1/2 right-1/3 w-64 h-64 bg-yellow-700/15 rounded-full blur-3xl animate-pulse-slow opacity-20" style="animation-delay: 3s;"></div>
      
      <!-- Premium Islamic Pattern Overlay -->
      <div class="absolute inset-0 opacity-[0.07]" style="background-image: url('data:image/svg+xml,%3Csvg width=\'80\' height=\'80\' viewBox=\'0 0 80 80\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cg fill=\'none\' fill-rule=\'evenodd\'%3E%3Cg fill=\'%23ffffff\' fill-opacity=\'1\'%3E%3Cpath d=\'M50 50c0-5.523 4.477-10 10-10s10 4.477 10 10-4.477 10-10 10c0 5.523-4.477 10-10 10s-10-4.477-10-10 4.477-10 10-10zM10 10c0-5.523 4.477-10 10-10s10 4.477 10 10-4.477 10-10 10c0 5.523-4.477 10-10 10S0 25.523 0 20s4.477-10 10-10zm10 8c4.418 0 8-3.582 8-8s-3.582-8-8-8-8 3.582-8 8 3.582 8 8 8zm40 40c4.418 0 8-3.582 8-8s-3.582-8-8-8-8 3.582-8 8 3.582 8 8 8z\' /%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>
      
      <!-- Gradient Overlay for Depth -->
      <div class="absolute inset-0 bg-gradient-to-t from-black/40 via-transparent to-black/20"></div>
      
      <!-- Glassmorphism Grid Lines (Subtle) -->
      <div class="absolute inset-0 opacity-[0.03]" style="background-image: linear-gradient(rgba(255,255,255,.05) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,.05) 1px, transparent 1px); background-size: 50px 50px;"></div>
    </div>

    <!-- Content -->
    <div class="container mx-auto px-4 lg:px-8 relative z-20 py-20">
      <div class="text-center max-w-4xl mx-auto">
        <!-- Badge -->
        <div class="inline-block mb-6">
          <span class="inline-flex items-center gap-2 px-4 py-2 bg-masjid-gold/20 backdrop-blur-sm text-masjid-gold-light text-sm font-medium rounded-full border border-masjid-gold/30">
            <PhBuilding :size="16" />
            <span>Masjid Jamie Al-Furqon Tasikmalaya</span>
          </span>
        </div>

        <!-- Heading -->
        <h1 class="text-4xl md:text-5xl lg:text-6xl font-serif font-bold text-white mb-6 leading-tight">
          Selamat Datang di<br />
          <span class="text-masjid-gold">Masjid Jamie Al-Furqon</span>
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
    <div class="absolute -bottom-28 left-0 right-0 z-30 md:hidden">
      <div class="container mx-auto px-4">
        <div class="grid grid-cols-2 gap-2">
          <div
            v-for="(stat, index) in stats"
            :key="index"
            class="bg-white/95 backdrop-blur-lg rounded-lg p-2.5 shadow-lg border border-masjid-gold/20"
          >
            <component :is="stat.icon" :size="20" class="text-masjid-gold mb-0.5" />
            <div class="text-lg font-serif font-bold text-masjid-dark leading-tight">
              {{ stat.value }}
            </div>
            <div class="text-[10px] text-masjid-text-muted leading-tight">
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
<style scoped>
@keyframes float {
  0%, 100% {
    transform: translate(0, 0) scale(1);
  }
  33% {
    transform: translate(30px, -30px) scale(1.05);
  }
  66% {
    transform: translate(-20px, 20px) scale(0.95);
  }
}

@keyframes float-slow {
  0%, 100% {
    transform: translate(0, 0) scale(1);
  }
  50% {
    transform: translate(-40px, -40px) scale(1.1);
  }
}

@keyframes pulse-slow {
  0%, 100% {
    opacity: 0.3;
  }
  50% {
    opacity: 0.5;
  }
}

.animate-float {
  animation: float 20s ease-in-out infinite;
}

.animate-float-slow {
  animation: float-slow 25s ease-in-out infinite;
}

.animate-pulse-slow {
  animation: pulse-slow 15s ease-in-out infinite;
}
</style>