<template>
  <div class="max-w-4xl space-y-6">
    <!-- Page Header Premium -->
    <div class="relative overflow-hidden rounded-2xl">
      <div class="absolute inset-0 bg-gradient-to-br from-masjid-gold/10 via-masjid-cream/10 to-white"></div>
      <div class="relative bg-white/60 backdrop-blur-md border border-white/60 rounded-2xl p-8 shadow-xl">
        <div class="flex items-center gap-4">
          <div class="w-14 h-14 rounded-xl bg-gradient-to-br from-masjid-gold to-masjid-dark flex items-center justify-center shadow-lg shadow-masjid-gold/20">
            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
            </svg>
          </div>
          <div>
            <h2 class="text-2xl font-serif font-bold text-masjid-dark">Pengaturan Website</h2>
            <p class="text-sm text-gray-600 mt-1">Kelola informasi dan pengaturan website masjid</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex justify-center py-12">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-masjid-gold"></div>
    </div>

    <form v-else @submit.prevent="handleSubmit" class="space-y-6">
      <!-- Donasi Settings Premium -->
      <div class="relative overflow-hidden">
        <div class="absolute inset-0 bg-gradient-to-br from-masjid-gold/5 via-masjid-cream/5 to-white rounded-2xl"></div>
        <div class="absolute -top-20 -right-20 w-40 h-40 bg-masjid-gold/10 rounded-full blur-3xl"></div>
        
        <div class="relative bg-white/80 backdrop-blur-xl rounded-2xl shadow-xl border border-white/60 p-8">
          <div class="flex items-center gap-4 mb-8 pb-6 border-b border-masjid-gold/20">
            <div class="w-12 h-12 flex items-center justify-center bg-gradient-to-br from-masjid-gold to-masjid-dark rounded-xl shadow-lg shadow-masjid-gold/20">
              <PhCurrencyCircleDollar :size="26" weight="duotone" class="text-white" />
            </div>
            <div>
              <h3 class="text-lg font-serif font-bold text-masjid-dark">
                💰 Pengaturan Donasi
              </h3>
              <p class="text-sm text-gray-600">
                Update progress donasi pembangunan gedung tahfizh
              </p>
            </div>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">Donasi Terkumpul (Rp) <span class="text-red-500">*</span></label>
              <input v-model.number="form.donation_collected" type="number" required min="0" step="1000" placeholder="45000000" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50" />
              <p class="text-xs font-semibold text-masjid-gold">{{ formatCurrency(form.donation_collected) }}</p>
            </div>

            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">Target Donasi (Rp) <span class="text-red-500">*</span></label>
              <input v-model.number="form.donation_target" type="number" required min="0" step="1000" placeholder="150000000" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-masjid-gold focus:ring-4 focus:ring-masjid-gold/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-masjid-gold/50" />
              <p class="text-xs font-semibold text-masjid-gold">{{ formatCurrency(form.donation_target) }}</p>
            </div>
          </div>

          <!-- Progress Preview Premium -->
          <div class="mt-6 p-6 bg-gradient-to-br from-masjid-gold/5 via-masjid-cream/5 to-white rounded-xl border border-masjid-gold/20 shadow-inner">
            <div class="flex justify-between items-center mb-3">
              <span class="text-sm font-semibold text-masjid-dark">📊 Preview Progress:</span>
              <span class="text-2xl font-bold text-masjid-gold">{{ donationPercentage }}%</span>
            </div>
            <div class="h-4 bg-gray-100 rounded-full overflow-hidden shadow-inner">
              <div class="h-full bg-gradient-to-r from-masjid-gold via-amber-500 to-masjid-dark rounded-full transition-all duration-500 shadow-lg" :style="{ width: `${donationPercentage}%` }"></div>
            </div>
          </div>
        </div>
      </div>

      <!-- Contact Settings Premium -->
      <div class="relative overflow-hidden">
        <div class="absolute inset-0 bg-gradient-to-br from-green-500/5 via-emerald-500/5 to-white rounded-2xl"></div>
        <div class="absolute -bottom-20 -left-20 w-40 h-40 bg-green-500/10 rounded-full blur-3xl"></div>
        
        <div class="relative bg-white/80 backdrop-blur-xl rounded-2xl shadow-xl border border-white/60 p-8">
          <div class="flex items-center gap-4 mb-8 pb-6 border-b border-green-500/20">
            <div class="w-12 h-12 flex items-center justify-center bg-gradient-to-br from-green-500 to-emerald-600 rounded-xl shadow-lg shadow-green-500/20">
              <PhDeviceMobile :size="26" weight="duotone" class="text-white" />
            </div>
            <div>
              <h3 class="text-lg font-serif font-bold text-masjid-dark">📱 Kontak & Sosial Media</h3>
              <p class="text-sm text-gray-600">Nomor WhatsApp dan link sosial media</p>
            </div>
          </div>

          <div class="space-y-6">
            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">Nomor WhatsApp <span class="text-red-500">*</span></label>
              <input v-model="form.whatsapp_number" type="text" required placeholder="628123456789" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-green-500 focus:ring-4 focus:ring-green-500/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-green-500/50" />
              <p class="text-xs text-gray-600">Format: 628xxx (tanpa +, tanpa spasi)</p>
            </div>

            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">Email Masjid</label>
              <input v-model="form.masjid_email" type="email" placeholder="masjid@alfurqan.com" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-green-500 focus:ring-4 focus:ring-green-500/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-green-500/50" />
            </div>
          </div>
        </div>
      </div>

      <!-- Masjid Info Premium -->
      <div class="relative overflow-hidden">
        <div class="absolute inset-0 bg-gradient-to-br from-blue-500/5 via-indigo-500/5 to-white rounded-2xl"></div>
        <div class="absolute -top-20 -left-20 w-40 h-40 bg-blue-500/10 rounded-full blur-3xl"></div>
        
        <div class="relative bg-white/80 backdrop-blur-xl rounded-2xl shadow-xl border border-white/60 p-8">
          <div class="flex items-center gap-4 mb-8 pb-6 border-b border-blue-500/20">
            <div class="w-12 h-12 flex items-center justify-center bg-gradient-to-br from-blue-500 to-indigo-600 rounded-xl shadow-lg shadow-blue-500/20">
              <PhBuilding :size="26" weight="duotone" class="text-white" />
            </div>
            <div>
              <h3 class="text-lg font-serif font-bold text-masjid-dark">🕌 Informasi Masjid</h3>
              <p class="text-sm text-gray-600">Data profil dan alamat masjid</p>
            </div>
          </div>

          <div class="space-y-6">
            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">Nama Masjid</label>
              <input v-model="form.masjid_name" type="text" placeholder="Masjid Jamie Al-Furqon" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 transition-all duration-300 outline-none placeholder:text-gray-400 shadow-sm hover:border-blue-500/50" />
            </div>

            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">Alamat Lengkap</label>
              <textarea v-model="form.masjid_address" rows="3" placeholder="Jl. Contoh No. 123, Tasikmalaya" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-blue-500 focus:ring-4 focus:ring-blue-500/10 transition-all duration-300 outline-none resize-none placeholder:text-gray-400 shadow-sm hover:border-blue-500/50"></textarea>
            </div>
          </div>
        </div>
      </div>

      <!-- Visi Misi Premium -->
      <div class="relative overflow-hidden">
        <div class="absolute inset-0 bg-gradient-to-br from-purple-500/5 via-pink-500/5 to-white rounded-2xl"></div>
        <div class="absolute -bottom-20 -right-20 w-40 h-40 bg-purple-500/10 rounded-full blur-3xl"></div>
        
        <div class="relative bg-white/80 backdrop-blur-xl rounded-2xl shadow-xl border border-white/60 p-8">
          <div class="flex items-center gap-4 mb-8 pb-6 border-b border-purple-500/20">
            <div class="w-12 h-12 flex items-center justify-center bg-gradient-to-br from-purple-500 to-pink-600 rounded-xl shadow-lg shadow-purple-500/20">
              <PhTarget :size="26" weight="duotone" class="text-white" />
            </div>
            <div>
              <h3 class="text-lg font-serif font-bold text-masjid-dark">🎯 Visi & Misi Masjid</h3>
              <p class="text-sm text-gray-600">Visi dan misi akan ditampilkan di halaman utama</p>
            </div>
          </div>

          <div class="space-y-6">
            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">Visi Masjid</label>
              <textarea v-model="form.masjid_visi" rows="4" placeholder="Menjadi masjid yang maju, mandiri, dan berkontribusi dalam pembinaan umat..." class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-purple-500 focus:ring-4 focus:ring-purple-500/10 transition-all duration-300 outline-none resize-none placeholder:text-gray-400 shadow-sm hover:border-purple-500/50"></textarea>
              <p class="text-xs text-gray-600">Tuliskan visi masjid dalam 1-2 paragraf</p>
            </div>

            <div class="space-y-2">
              <label class="block text-sm font-semibold text-masjid-dark">Misi Masjid</label>
              <textarea v-model="form.masjid_misi" rows="8" placeholder="Menyelenggarakan kegiatan dakwah dan pendidikan Islam yang berkualitas&#10;Membina generasi Qurani melalui program tahfizh dan kajian rutin&#10;Mengembangkan ekonomi umat melalui program sosial dan pemberdayaan" class="w-full px-5 py-3.5 rounded-xl border-2 border-gray-200 bg-white/70 backdrop-blur-sm focus:bg-white focus:border-purple-500 focus:ring-4 focus:ring-purple-500/10 transition-all duration-300 outline-none resize-none placeholder:text-gray-400 shadow-sm hover:border-purple-500/50 font-mono text-sm"></textarea>
              <div class="flex items-start gap-2 text-xs text-gray-600 bg-purple-50/50 rounded-lg p-3 border border-purple-100">
                <PhLightbulb :size="14" class="flex-shrink-0 mt-0.5 text-purple-500" weight="fill" />
                <p><strong class="text-purple-700">Tips:</strong> Pisahkan setiap poin misi dengan enter (baris baru). Setiap baris akan ditampilkan sebagai poin terpisah dengan nomor otomatis.</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Premium Submit Buttons -->
      <div class="sticky bottom-6 z-10">
        <div class="relative overflow-hidden rounded-2xl">
          <div class="absolute inset-0 bg-white/95 backdrop-blur-xl"></div>
          <div class="relative bg-gradient-to-r from-white/80 to-white/60 backdrop-blur-xl border-2 border-white/80 rounded-2xl p-6 shadow-2xl shadow-masjid-gold/20">
            <div class="flex flex-col-reverse sm:flex-row gap-4">
              <button type="button" @click="loadSettings" class="sm:w-40 inline-flex items-center justify-center gap-2 px-6 py-3.5 bg-white border-2 border-gray-200 hover:border-gray-300 hover:bg-gray-50 text-gray-700 font-semibold rounded-xl transition-all duration-300 shadow-sm">
                <PhArrowClockwise :size="20" />
                <span>Reset</span>
              </button>
              <button type="submit" :disabled="submitting" class="flex-1 inline-flex items-center justify-center gap-2 px-6 py-3.5 bg-gradient-to-r from-masjid-gold to-masjid-dark hover:from-masjid-dark hover:to-masjid-gold text-white font-semibold rounded-xl transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg shadow-masjid-gold/30 hover:shadow-xl hover:shadow-masjid-gold/40 hover:scale-[1.02] active:scale-[0.98]">
                <template v-if="!submitting">
                  <PhFloppyDisk :size="20" />
                  <span>Simpan Pengaturan</span>
                </template>
                <span v-else class="flex items-center gap-2"><svg class="animate-spin w-5 h-5" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>Menyimpan...</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </form>
  </div>
</template>

<script setup lang="ts">
import { PhBuilding, PhCurrencyCircleDollar, PhDeviceMobile, PhTarget, PhLightbulb, PhFloppyDisk, PhArrowClockwise } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const { fetchSettingsObject, updateSettings } = useSettings()
const toast = useToast()

const loading = ref(true)
const submitting = ref(false)

const form = ref({
  donation_collected: 0,
  donation_target: 0,
  whatsapp_number: '',
  masjid_email: '',
  masjid_name: '',
  masjid_address: '',
  masjid_visi: '',
  masjid_misi: ''
})

const donationPercentage = computed(() => {
  if (!form.value.donation_target) return 0
  return Math.min(Math.round((form.value.donation_collected / form.value.donation_target) * 100), 100)
})

const formatCurrency = (amount: number) => {
  if (!amount) return 'Rp 0'
  return 'Rp ' + new Intl.NumberFormat('id-ID').format(amount)
}

const loadSettings = async () => {
  loading.value = true
  
  try {
    const settings = await fetchSettingsObject()
    
    form.value = {
      donation_collected: parseInt(settings.donation_collected || '0'),
      donation_target: parseInt(settings.donation_target || '0'),
      whatsapp_number: settings.whatsapp_number || '',
      masjid_email: settings.masjid_email || '',
      masjid_name: settings.masjid_name || '',
      masjid_address: settings.masjid_address || '',
      masjid_visi: settings.masjid_visi || '',
      masjid_misi: settings.masjid_misi || ''
    }
  } catch (err: any) {
    console.error('Error loading settings:', err)
    toast.error('Gagal memuat pengaturan')
  } finally {
    loading.value = false
  }
}

const handleSubmit = async () => {
  submitting.value = true

  try {
    await updateSettings({
      donation_collected: form.value.donation_collected.toString(),
      donation_target: form.value.donation_target.toString(),
      whatsapp_number: form.value.whatsapp_number,
      masjid_email: form.value.masjid_email,
      masjid_name: form.value.masjid_name,
      masjid_address: form.value.masjid_address,
      masjid_visi: form.value.masjid_visi,
      masjid_misi: form.value.masjid_misi
    })

    toast.success('Pengaturan berhasil disimpan!')
  } catch (err: any) {
    console.error('Error updating settings:', err)
    toast.error('Gagal menyimpan pengaturan')
  } finally {
    submitting.value = false
  }
}

onMounted(() => {
  loadSettings()
})
</script>
