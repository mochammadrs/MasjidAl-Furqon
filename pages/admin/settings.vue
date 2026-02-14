<template>
  <div class="max-w-4xl space-y-6">
    <!-- Page Header -->
    <div>
      <h2 class="text-2xl font-serif font-bold text-masjid-dark">Pengaturan Website</h2>
      <p class="text-sm text-masjid-text-muted mt-1">Kelola informasi dan pengaturan website masjid</p>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex justify-center py-12">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-masjid-gold"></div>
    </div>

    <form v-else @submit.prevent="handleSubmit" class="space-y-6">
      <!-- Donasi Settings -->
      <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
        <div class="flex items-center gap-3 mb-6">
          <div class="w-10 h-10 flex items-center justify-center bg-masjid-gold/10 rounded-lg">
            <PhCurrencyCircleDollar :size="24" class="text-masjid-gold" />
          </div>
          <div>
            <h3 class="text-lg font-serif font-bold text-masjid-dark">
              Pengaturan Donasi
            </h3>
            <p class="text-sm text-masjid-text-muted">
              Update progress donasi pembangunan gedung tahfizh
            </p>
          </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Donasi Terkumpul (Rp)
            </label>
            <input
              v-model.number="form.donation_collected"
              type="number"
              required
              min="0"
              step="1000"
              placeholder="45000000"
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
            <p class="text-xs text-masjid-text-muted mt-1">
              {{ formatCurrency(form.donation_collected) }}
            </p>
          </div>

          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Target Donasi (Rp)
            </label>
            <input
              v-model.number="form.donation_target"
              type="number"
              required
              min="0"
              step="1000"
              placeholder="150000000"
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
            <p class="text-xs text-masjid-text-muted mt-1">
              {{ formatCurrency(form.donation_target) }}
            </p>
          </div>
        </div>

        <!-- Progress Preview -->
        <div class="mt-4 p-4 bg-masjid-cream rounded-lg">
          <div class="flex justify-between items-center mb-2">
            <span class="text-sm text-masjid-dark">Preview Progress:</span>
            <span class="text-lg font-bold text-masjid-gold">{{ donationPercentage }}%</span>
          </div>
          <div class="h-3 bg-masjid-gold-light rounded-full overflow-hidden">
            <div
              class="h-full bg-gradient-to-r from-masjid-gold to-masjid-dark rounded-full transition-all duration-500"
              :style="{ width: `${donationPercentage}%` }"
            ></div>
          </div>
        </div>
      </div>

      <!-- Contact Settings -->
      <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
        <div class="flex items-center gap-3 mb-6">
          <div class="w-10 h-10 flex items-center justify-center bg-masjid-gold/10 rounded-lg">
            <PhDeviceMobile :size="24" class="text-masjid-gold" />
          </div>
          <div>
            <h3 class="text-lg font-serif font-bold text-masjid-dark">
              Kontak & Sosial Media
            </h3>
            <p class="text-sm text-masjid-text-muted">
              Nomor WhatsApp dan link sosial media
            </p>
          </div>
        </div>

        <div class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Nomor WhatsApp
            </label>
            <input
              v-model="form.whatsapp_number"
              type="text"
              required
              placeholder="628123456789"
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
            <p class="text-xs text-masjid-text-muted mt-1">
              Format: 628xxx (tanpa +, tanpa spasi)
            </p>
          </div>

          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Email Masjid
            </label>
            <input
              v-model="form.masjid_email"
              type="email"
              placeholder="masjid@alfurqan.com"
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
          </div>
        </div>
      </div>

      <!-- Masjid Info -->
      <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
        <div class="flex items-center gap-3 mb-6">
          <div class="w-10 h-10 flex items-center justify-center bg-masjid-gold/10 rounded-lg">
            <PhBuilding :size="24" class="text-masjid-gold" />
          </div>
          <div>
            <h3 class="text-lg font-serif font-bold text-masjid-dark">
              Informasi Masjid
            </h3>
            <p class="text-sm text-masjid-text-muted">
              Data profil dan alamat masjid
            </p>
          </div>
        </div>

        <div class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Nama Masjid
            </label>
            <input
              v-model="form.masjid_name"
              type="text"
              placeholder="Masjid Al-Furqon"
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Alamat Lengkap
            </label>
            <textarea
              v-model="form.masjid_address"
              rows="3"
              placeholder="Jl. Contoh No. 123, Tasikmalaya"
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none resize-none"
            ></textarea>
          </div>
        </div>
      </div>

      <!-- Visi Misi -->
      <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
        <div class="flex items-center gap-3 mb-6">
          <div class="w-10 h-10 flex items-center justify-center bg-masjid-gold/10 rounded-lg">
            <PhTarget :size="24" class="text-masjid-gold" />
          </div>
          <div>
            <h3 class="text-lg font-serif font-bold text-masjid-dark">
              Visi & Misi Masjid
            </h3>
            <p class="text-sm text-masjid-text-muted">
              Visi dan misi akan ditampilkan di halaman utama
            </p>
          </div>
        </div>

        <div class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Visi Masjid
            </label>
            <textarea
              v-model="form.masjid_visi"
              rows="4"
              placeholder="Menjadi masjid yang maju, mandiri, dan berkontribusi dalam pembinaan umat..."
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none resize-none"
            ></textarea>
            <p class="text-xs text-masjid-text-muted mt-1">
              Tuliskan visi masjid dalam 1-2 paragraf
            </p>
          </div>

          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Misi Masjid
            </label>
            <textarea
              v-model="form.masjid_misi"
              rows="8"
              placeholder="Menyelenggarakan kegiatan dakwah dan pendidikan Islam yang berkualitas&#10;Membina generasi Qurani melalui program tahfizh dan kajian rutin&#10;Mengembangkan ekonomi umat melalui program sosial dan pemberdayaan"
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none resize-none font-mono text-sm"
            ></textarea>
            <div class="flex items-start gap-2 text-xs text-masjid-text-muted mt-1">
              <PhLightbulb :size="14" class="flex-shrink-0 mt-0.5" weight="fill" />
              <p>
                <strong>Tips:</strong> Pisahkan setiap poin misi dengan enter (baris baru). Setiap baris akan ditampilkan sebagai poin terpisah dengan nomor otomatis.
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Submit Buttons -->
      <div class="flex gap-3 sticky bottom-6 bg-white/95 backdrop-blur-sm border border-gray-200 rounded-xl p-4 shadow-lg">
        <button
          type="submit"
          :disabled="submitting"
          class="flex-1 inline-flex items-center justify-center gap-2 px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          <template v-if="!submitting">
            <PhFloppyDisk :size="20" />
            <span>Simpan Pengaturan</span>
          </template>
          <span v-else>Menyimpan...</span>
        </button>
        <button
          type="button"
          @click="loadSettings"
          class="inline-flex items-center gap-2 px-6 py-3 bg-gray-100 hover:bg-gray-200 text-masjid-dark font-medium rounded-lg transition-colors"
        >
          <PhArrowClockwise :size="20" />
          <span>Reset</span>
        </button>
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
