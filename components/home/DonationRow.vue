<template>
  <section id="donasi" class="relative py-16 md:py-20 overflow-hidden">
    <!-- Premium Background -->
    <div class="absolute inset-0 bg-gradient-to-br from-masjid-cream via-masjid-gold-light/20 to-white"></div>
    
    <!-- Animated Decorative Elements -->
    <div class="absolute top-1/4 -right-40 w-96 h-96 bg-gradient-to-br from-masjid-gold/10 to-transparent rounded-full blur-3xl animate-pulse-slow"></div>
    <div class="absolute -bottom-32 -left-40 w-80 h-80 bg-gradient-to-br from-amber-500/8 to-transparent rounded-full blur-3xl animate-pulse-slow" style="animation-delay: 2s;"></div>
    
    <!-- Heart Pattern Overlay -->
    <div class="absolute inset-0 opacity-[0.02]" style="background-image: url('data:image/svg+xml,%3Csvg width=\'60\' height=\'60\' viewBox=\'0 0 60 60\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cpath d=\'M30 20c5-5 15-3 15 5 0 8-15 15-15 15S15 33 15 25c0-8 10-10 15-5z\' fill=\'%23C6A87C\' fill-opacity=\'1\'/%3E%3C/svg%3E'); background-size: 120px 120px;"></div>
    
    <div class="container mx-auto px-4 lg:px-8 relative z-10">
      <!-- Section Header -->
      <div class="text-center mb-12">
        <div class="inline-flex items-center gap-2 px-4 py-2 bg-masjid-gold-light rounded-full mb-4">
          <PhHandHeart :size="16" class="text-masjid-dark" weight="fill" />
          <span class="text-sm font-medium text-masjid-dark">Sedekah Jariyah</span>
        </div>
        <h2 class="text-3xl md:text-4xl font-serif font-bold text-masjid-dark mb-3">
          Donasi & Infak
        </h2>
        <p class="text-masjid-text-muted max-w-2xl mx-auto">
          Salurkan donasi Anda untuk pembangunan dan operasional masjid. Setiap kontribusi Anda sangat berarti.
        </p>
      </div>

      <div class="max-w-6xl mx-auto grid grid-cols-1 lg:grid-cols-3 gap-6">
        <!-- Bank Account Card -->
        <div class="bg-gradient-to-br from-masjid-gold to-masjid-dark rounded-2xl p-8 text-white shadow-2xl">
          <div class="flex items-start justify-between mb-6">
            <div>
              <h3 class="text-xl font-serif font-bold mb-2">Rekening Donasi</h3>
              <p class="text-sm text-white/80">Transfer melalui rekening resmi DKM</p>
            </div>
            <svg class="w-12 h-12 text-white/20" fill="currentColor" viewBox="0 0 24 24">
              <path d="M19 14V6c0-1.1-.9-2-2-2H3c-1.1 0-2 .9-2 2v8c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2zm-9-1c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3zm13-6v11c0 1.1-.9 2-2 2H4v-2h17V7h2z"/>
            </svg>
          </div>

          <!-- Bank Info -->
          <div class="space-y-4">
            <div class="bg-white/10 backdrop-blur-sm rounded-lg p-4 border border-white/20">
              <div class="text-xs text-white/70 mb-1">Bank Rakyat Indonesia (BRI)</div>
              <div class="flex items-center justify-between">
                <div class="text-2xl font-bold tracking-wider">4362 0105 7466 536</div>
                <button
                  @click="copyBankAccount('BRI', '43620105746536')"
                  class="p-2 hover:bg-white/10 rounded-lg transition-colors"
                  title="Salin nomor rekening"
                >
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"/>
                  </svg>
                </button>
              </div>
              <div class="text-sm mt-2">a.n. <strong>DKM Masjid Jamie Al-Furqon</strong></div>
            </div>
          </div>
        </div>

        <!-- QRIS Card (NEW) -->
        <div class="bg-white rounded-2xl p-8 shadow-xl border border-masjid-border">
          <div class="flex items-start justify-between mb-6">
            <div>
              <h3 class="text-xl font-serif font-bold text-masjid-dark mb-2">QRIS Donasi</h3>
              <p class="text-sm text-masjid-text-muted">Scan untuk berdonasi via QRIS</p>
            </div>
            <svg class="w-10 h-10 text-masjid-gold" fill="currentColor" viewBox="0 0 24 24">
              <path d="M3 11h8V3H3v8zm2-6h4v4H5V5zm8-2v8h8V3h-8zm6 6h-4V5h4v4zM3 21h8v-8H3v8zm2-6h4v4H5v-4zm13-2h-2v3h-3v2h3v3h2v-3h3v-2h-3v-3z"/>
            </svg>
          </div>

          <!-- QRIS Image -->
          <div class="mb-6">
            <div class="bg-masjid-cream rounded-xl p-4 border-2 border-dashed border-masjid-gold/30">
              <div class="bg-white rounded-lg flex items-center justify-center overflow-hidden">
                <img src="/images/qris-masjid.jpeg" alt="QRIS Masjid Jamie Al-Furqon" class="w-full h-full" loading="lazy" decoding="async" />
              </div>
            </div>
          </div>

          <div class="space-y-3">
            <div class="flex items-center gap-2 text-sm text-masjid-text-muted">
              <svg class="w-5 h-5 text-masjid-gold" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
              </svg>
              <span>Semua e-wallet & mobile banking</span>
            </div>
            <div class="flex items-center gap-2 text-sm text-masjid-text-muted">
              <svg class="w-5 h-5 text-masjid-gold" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
              </svg>
              <span>Instant & aman</span>
            </div>
            <div class="flex items-center gap-2 text-sm text-masjid-text-muted">
              <svg class="w-5 h-5 text-masjid-gold" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
              </svg>
              <span>a.n. DKM Al-Furqon</span>
            </div>
          </div>

          <div class="mt-6 p-4 bg-blue-50 rounded-lg border border-blue-200">
            <div class="flex items-start gap-2">
              <PhLightbulb :size="16" class="text-blue-600 flex-shrink-0 mt-0.5" weight="fill" />
              <p class="text-xs text-blue-800">
                Screenshot bukti transfer untuk konfirmasi via WhatsApp
              </p>
            </div>
          </div>
        </div>

        <!-- Fundraising Progress Card -->
        <div class="bg-white rounded-2xl p-8 shadow-xl border border-masjid-border">
          <div class="mb-6">
            <h3 class="text-xl font-serif font-bold text-masjid-dark mb-2">
              Program Pembangunan Gedung Tahfizh
            </h3>
            <p class="text-sm text-masjid-text-muted">
              Mari bersama-sama mewujudkan rumah tahfizh Al-Quran
            </p>
          </div>

          <!-- Progress Stats -->
          <div class="space-y-4">
            <div class="flex justify-between items-end">
              <div>
                <div class="text-xs text-masjid-text-muted mb-1">Terkumpul</div>
                <div class="text-2xl font-bold text-masjid-gold">
                  Rp {{ formatCurrency(currentAmount) }}
                </div>
              </div>
              <div class="text-right">
                <div class="text-xs text-masjid-text-muted mb-1">Target</div>
                <div class="text-lg font-semibold text-masjid-dark">
                  Rp {{ formatCurrency(targetAmount) }}
                </div>
              </div>
            </div>

            <!-- Progress Bar -->
            <div class="relative">
              <div class="h-4 bg-masjid-gold-light rounded-full overflow-hidden">
                <div
                  class="h-full bg-gradient-to-r from-masjid-gold to-masjid-dark rounded-full transition-all duration-1000 ease-out"
                  :style="{ width: `${progressPercentage}%` }"
                ></div>
              </div>
              <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2">
                <span class="text-xs font-bold text-white drop-shadow-lg">
                  {{ progressPercentage }}%
                </span>
              </div>
            </div>

            <!-- Donor Count -->
            <div class="flex items-center gap-2 text-sm text-masjid-text-muted">
              <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                <path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/>
              </svg>
              <span>Didukung oleh <strong>{{ donorCount }}+ donatur</strong></span>
            </div>
          </div>

          <!-- CTA Button -->
          <button
            @click="scrollToBankInfo"
            class="mt-6 w-full px-6 py-3.5 bg-masjid-gold hover:bg-masjid-dark text-white font-semibold rounded-lg transition-colors shadow-lg hover:shadow-xl"
          >
            Donasi Sekarang
          </button>

          <!-- Info Note -->
          <div class="flex items-center justify-center gap-2 mt-4 text-xs text-center text-masjid-text-muted">
            <PhLightbulb :size="14" weight="fill" />
            <p>Konfirmasi donasi via WhatsApp untuk laporan transparan</p>
          </div>
        </div>
      </div>

      <!-- Confirmation Note -->
      <div class="mt-12 max-w-3xl mx-auto">
        <div class="bg-blue-50 border border-blue-200 rounded-lg p-6">
          <div class="flex gap-4">
            <div class="flex-shrink-0">
              <svg class="w-6 h-6 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
              </svg>
            </div>
            <div class="flex-1">
              <h4 class="font-semibold text-blue-900 mb-1">Konfirmasi Donasi</h4>
              <p class="text-sm text-blue-800">
                Setelah transfer, mohon konfirmasi melalui WhatsApp dengan format: <br>
                <code class="bg-blue-100 px-2 py-1 rounded text-xs">Nama - Nominal - Bukti Transfer</code>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { PhHandHeart, PhLightbulb } from '@phosphor-icons/vue'

const { fetchSettingsObject } = useSettings()

// Fetch data from database
const currentAmount = ref(45000000)
const targetAmount = ref(150000000)
const donorCount = ref(127)
const loading = ref(true)

const progressPercentage = computed(() => {
  return Math.min(Math.round((currentAmount.value / targetAmount.value) * 100), 100)
})

const formatCurrency = (amount: number) => {
  return new Intl.NumberFormat('id-ID').format(amount)
}

const copyBankAccount = async (bank: string, account: string) => {
  try {
    await navigator.clipboard.writeText(account)
    alert(`✅ Nomor rekening ${bank} berhasil disalin!`)
  } catch (err) {
    alert('❌ Gagal menyalin nomor rekening')
  }
}

const scrollToBankInfo = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

// Load donation settings from database
const loadDonationSettings = async () => {
  try {
    const settings = await fetchSettingsObject()
    
    if (settings.donation_collected) {
      currentAmount.value = parseInt(settings.donation_collected)
    }
    if (settings.donation_target) {
      targetAmount.value = parseInt(settings.donation_target)
    }
  } catch (error) {
    console.error('Error loading donation settings:', error)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  loadDonationSettings()
})
</script>
<style scoped>
@keyframes pulse-slow {
  0%, 100% {
    opacity: 0.4;
    transform: scale(1);
  }
  50% {
    opacity: 0.6;
    transform: scale(1.15);
  }
}

.animate-pulse-slow {
  animation: pulse-slow 16s ease-in-out infinite;
}
</style>