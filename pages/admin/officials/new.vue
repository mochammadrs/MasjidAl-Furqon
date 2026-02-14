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

    <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
      <h2 class="text-2xl font-serif font-bold text-masjid-dark mb-6">
        Tambah Pengurus Baru
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
                  v-if="photoPreview"
                  :src="photoPreview"
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
                Pilih Foto
              </button>
              <p class="text-xs text-masjid-text-muted mt-2">
                Format: JPG, PNG. Maksimal 2MB. Rekomendasi: 500x500px
              </p>
              <button
                v-if="photoPreview"
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
            class="flex-1 px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-colors disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
          >
            <span v-if="submitting" class="animate-spin rounded-full h-5 w-5 border-2 border-white border-t-transparent"></span>
            <PhFloppyDisk v-else :size="20" />
            <span>{{ submitting ? 'Menyimpan...' : 'Simpan Pengurus' }}</span>
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
import { PhUser, PhFloppyDisk } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const { createOfficial, uploadOfficialPhoto } = useOfficials()
const toast = useToast()

const form = ref({
  name: '',
  position: '',
  phone: '',
  email: '',
  bio: '',
  display_order: 1,
  is_active: true
})

const photoInput = ref<HTMLInputElement>()
const photoFile = ref<File | null>(null)
const photoPreview = ref<string>('')
const submitting = ref(false)

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

const removePhoto = () => {
  photoFile.value = null
  photoPreview.value = ''
  if (photoInput.value) {
    photoInput.value.value = ''
  }
}

const handleSubmit = async () => {
  submitting.value = true

  try {
    // Create official without photo first
    const official = await createOfficial({
      name: form.value.name,
      position: form.value.position,
      phone: form.value.phone || null,
      email: form.value.email || null,
      bio: form.value.bio || null,
      display_order: form.value.display_order,
      is_active: form.value.is_active
    })

    // Upload photo if exists
    if (photoFile.value && official?.id) {
      try {
        await uploadOfficialPhoto(photoFile.value, official.id)
      } catch (uploadError) {
        console.error('Error uploading photo:', uploadError)
        // Don't fail the whole operation if photo upload fails
      }
    }

    toast.success('Pengurus berhasil ditambahkan!')
    
    // Redirect to list
    await navigateTo('/admin/officials')
  } catch (err: any) {
    console.error('Error creating official:', err)
    toast.error(err.message || 'Gagal menyimpan data pengurus')
  } finally {
    submitting.value = false
  }
}
</script>
