<template>
  <div class="max-w-4xl">
    <div class="mb-6">
      <NuxtLink
        to="/admin/officials"
        class="text-sm text-masjid-gold hover:text-masjid-dark transition-colors inline-flex items-center gap-1"
      >
        ← Kembali ke Daftar Pengurus
      </NuxtLink>
    </div>

    <div v-if="loading" class="flex justify-center items-center min-h-[400px]">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-masjid-gold"></div>
    </div>

    <div v-else-if="!official" class="text-center py-16">
      <div class="inline-flex items-center justify-center w-20 h-20 rounded-2xl bg-gray-100 mb-5">
        <PhWarning :size="40" class="text-gray-400" />
      </div>
      <h2 class="text-2xl font-serif font-bold text-masjid-dark mb-3">
        Pengurus Tidak Ditemukan
      </h2>
      <NuxtLink
        to="/admin/officials"
        class="inline-block px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-colors"
      >
        ← Kembali ke Daftar
      </NuxtLink>
    </div>

    <div v-else class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
      <h2 class="text-2xl font-serif font-bold text-masjid-dark mb-6">
        Edit Pengurus: {{ official.name }}
      </h2>

      <form @submit.prevent="handleSubmit" class="space-y-6">
        <!-- Photo Upload -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Foto Pengurus
          </label>
          <div class="flex items-start gap-4">
            <!-- Preview -->
            <div class="flex-shrink-0">
              <div class="w-32 h-32 rounded-full bg-gray-100 border-2 border-dashed border-gray-300 flex items-center justify-center overflow-hidden">
                <img
                  v-if="photoPreview || form.photo_url"
                  :src="photoPreview || form.photo_url || ''"
                  alt="Preview"
                  class="w-full h-full object-cover"
                />
                <PhUser v-else :size="48" class="text-gray-300" />
              </div>
            </div>
            <!-- Upload Button -->
            <div class="flex-1">
              <input
                ref="photoInput"
                type="file"
                accept="image/*"
                @change="handlePhotoChange"
                class="hidden"
              />
              <button
                type="button"
                @click="photoInput?.click()"
                class="px-4 py-2 bg-gray-100 hover:bg-gray-200 text-masjid-dark rounded-lg transition-colors"
              >
                {{ form.photo_url ? 'Ganti Foto' : 'Pilih Foto' }}
              </button>
              <p class="text-xs text-masjid-text-muted mt-2">
                Format: JPG, PNG. Maksimal 2MB. Rekomendasi: 500x500px
              </p>
              <button
                v-if="photoPreview || form.photo_url"
                type="button"
                @click="removePhoto"
                class="text-sm text-red-600 hover:text-red-700 mt-2"
              >
                Hapus Foto
              </button>
            </div>
          </div>
        </div>

        <!-- Name -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Nama Lengkap *
          </label>
          <input
            v-model="form.name"
            type="text"
            required
            placeholder="Contoh: Ustadz Ahmad Hidayat"
            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
          />
        </div>

        <!-- Position -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Jabatan *
          </label>
          <input
            v-model="form.position"
            type="text"
            required
            placeholder="Contoh: Ketua Takmir"
            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
          />
        </div>

        <!-- Contact Info -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Nomor Telepon
            </label>
            <input
              v-model="form.phone"
              type="tel"
              placeholder="08123456789"
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
          </div>
          <div>
            <label class="block text-sm font-medium text-masjid-dark mb-2">
              Email
            </label>
            <input
              v-model="form.email"
              type="email"
              placeholder="email@example.com"
              class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
            />
          </div>
        </div>

        <!-- Bio -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Biografi Singkat
          </label>
          <textarea
            v-model="form.bio"
            rows="4"
            placeholder="Jelaskan latar belakang, pendidikan, atau pengalaman..."
            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none resize-none"
          ></textarea>
        </div>

        <!-- Display Order -->
        <div>
          <label class="block text-sm font-medium text-masjid-dark mb-2">
            Urutan Tampilan *
          </label>
          <input
            v-model.number="form.display_order"
            type="number"
            required
            min="1"
            placeholder="1"
            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-masjid-gold focus:border-transparent transition-all outline-none"
          />
          <p class="text-xs text-masjid-text-muted mt-1">
            Semakin kecil angka, semakin tinggi urutan tampilan
          </p>
        </div>

        <!-- Status -->
        <div>
          <label class="flex items-center gap-2 cursor-pointer">
            <input
              v-model="form.is_active"
              type="checkbox"
              class="w-5 h-5 rounded border-gray-300 text-masjid-gold focus:ring-masjid-gold"
            />
            <span class="text-sm font-medium text-masjid-dark">
              Tampilkan di website (Aktif)
            </span>
          </label>
        </div>

        <!-- Submit Buttons -->
        <div class="flex gap-3 pt-4">
          <button
            type="submit"
            :disabled="submitting"
            class="flex-1 px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <span v-if="submitting">Menyimpan...</span>
            <span v-else>Simpan Perubahan</span>
          </button>
          <NuxtLink
            to="/admin/officials"
            class="px-6 py-3 bg-gray-100 hover:bg-gray-200 text-masjid-dark font-medium rounded-lg transition-colors text-center"
          >
            Batal
          </NuxtLink>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PhWarning, PhUser } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const route = useRoute()
const { fetchOfficial, updateOfficial, uploadOfficialPhoto, deleteOfficialPhoto } = useOfficials()
const toast = useToast()

const officialId = computed(() => route.params.id as string)

const official = ref<any>(null)
const loading = ref(true)

const form = ref({
  name: '',
  position: '',
  phone: '',
  email: '',
  bio: '',
  display_order: 1,
  is_active: true,
  photo_url: ''
})

const photoInput = ref<HTMLInputElement>()
const photoFile = ref<File | null>(null)
const photoPreview = ref<string>('')
const submitting = ref(false)

// Fetch official data
const loadOfficial = async () => {
  loading.value = true
  try {
    const data = await fetchOfficial(officialId.value)
    if (data) {
      official.value = data
      form.value = {
        name: data.name || '',
        position: data.position || '',
        phone: data.phone || '',
        email: data.email || '',
        bio: data.bio || '',
        display_order: data.display_order || 1,
        is_active: data.is_active ?? true,
        photo_url: data.photo_url || ''
      }
    }
  } catch (err) {
    console.error('Error loading official:', err)
  } finally {
    loading.value = false
  }
}

const handlePhotoChange = (event: Event) => {
  const target = event.target as HTMLInputElement
  const file = target.files?.[0]
  
  if (!file) return

  // Validate file size (max 2MB)
  if (file.size > 2 * 1024 * 1024) {
    toast.error('Ukuran file terlalu besar. Maksimal 2MB.')
    return
  }

  // Validate file type
  if (!file.type.startsWith('image/')) {
    toast.error('File harus berupa gambar.')
    return
  }

  photoFile.value = file
  
  // Create preview
  const reader = new FileReader()
  reader.onload = (e) => {
    photoPreview.value = e.target?.result as string
  }
  reader.readAsDataURL(file)
}

const removePhoto = async () => {
  if (form.value.photo_url) {
    const confirmed = confirm('Hapus foto yang sudah ada?')
    if (confirmed) {
      try {
        await deleteOfficialPhoto(form.value.photo_url)
        form.value.photo_url = ''
        photoPreview.value = ''
        photoFile.value = null
        if (photoInput.value) {
          photoInput.value.value = ''
        }
        toast.success('Foto berhasil dihapus')
      } catch (err) {
        console.error('Error deleting photo:', err)
        toast.error('Gagal menghapus foto')
      }
    }
  } else {
    photoFile.value = null
    photoPreview.value = ''
    if (photoInput.value) {
      photoInput.value.value = ''
    }
  }
}

const handleSubmit = async () => {
  submitting.value = true

  try {
    // Upload new photo if selected
    if (photoFile.value) {
      try {
        // Delete old photo if exists
        if (form.value.photo_url) {
          await deleteOfficialPhoto(form.value.photo_url)
        }
        // Upload new photo
        await uploadOfficialPhoto(photoFile.value, officialId.value)
      } catch (uploadError) {
        console.error('Error uploading photo:', uploadError)
        // Don't fail the whole operation if photo upload fails
      }
    }

    // Update official data
    await updateOfficial(officialId.value, {
      name: form.value.name,
      position: form.value.position,
      phone: form.value.phone || null,
      email: form.value.email || null,
      bio: form.value.bio || null,
      display_order: form.value.display_order,
      is_active: form.value.is_active
    })

    toast.success('Perubahan berhasil disimpan!')
    
    // Redirect to list
    await navigateTo('/admin/officials')
  } catch (err: any) {
    console.error('Error updating official:', err)
    toast.error(err.message || 'Gagal menyimpan perubahan')
  } finally {
    submitting.value = false
  }
}

onMounted(() => {
  loadOfficial()
})
</script>
