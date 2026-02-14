<template>
  <NuxtLayout name="admin">
    <div class="space-y-6">
      <!-- Add Button -->
    <div class="flex justify-end">
      <NuxtLink
        to="/admin/officials/new"
        class="px-4 py-2.5 bg-masjid-gold hover:bg-masjid-dark text-white font-semibold rounded-lg transition-all duration-300 flex items-center gap-2 shadow-md hover:shadow-lg"
      >
        <PhPlus :size="18" />
        <span>Tambah Pengurus</span>
      </NuxtLink>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex justify-center py-12">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-masjid-gold"></div>
    </div>

    <!-- Officials Table -->
    <div v-else class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
      <div v-if="officials.length === 0" class="text-center py-16">
        <div class="inline-flex items-center justify-center w-20 h-20 rounded-2xl bg-gray-100 mb-5">
          <PhUsers :size="40" class="text-gray-400" />
        </div>
        <p class="text-masjid-text-muted mb-6 text-lg">Belum ada data pengurus</p>
        <NuxtLink
          to="/admin/officials/new"
          class="inline-flex items-center gap-2 px-5 py-2.5 bg-masjid-gold hover:bg-masjid-dark text-white font-semibold rounded-lg transition-all duration-300"
        >
          <PhPlus :size="18" />
          <span>Tambah Pengurus Pertama</span>
        </NuxtLink>
      </div>

      <div v-else class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-gray-50 border-b border-gray-200">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Pengurus
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Jabatan
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Kontak
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Status
              </th>
              <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                Aksi
              </th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <tr
              v-for="official in officials"
              :key="official.id"
              class="hover:bg-gray-50 transition-colors"
            >
              <td class="px-6 py-4">
                <div class="flex items-center gap-3">
                  <div
                    v-if="official.photo_url"
                    class="w-12 h-12 rounded-full overflow-hidden flex-shrink-0"
                  >
                    <img :src="official.photo_url" :alt="official.name" class="w-full h-full object-cover" loading="lazy" decoding="async" />
                  </div>
                  <div
                    v-else
                    class="w-12 h-12 rounded-full bg-gray-100 flex items-center justify-center flex-shrink-0"
                  >
                    <PhUser :size="24" class="text-gray-400" />
                  </div>
                  <div class="min-w-0 flex-1">
                    <p class="font-medium text-masjid-dark">{{ official.name }}</p>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <p class="font-medium text-masjid-dark">{{ official.position }}</p>
                <p class="text-xs text-masjid-text-muted">Urutan: {{ official.display_order }}</p>
              </td>
              <td class="px-6 py-4">
                <div class="flex items-start gap-2 text-sm">
                  <div v-if="official.phone" class="flex items-center gap-1.5 text-masjid-dark">
                    <PhPhone :size="14" class="flex-shrink-0" />
                    <span>{{ official.phone }}</span>
                  </div>
                  <div v-if="official.email" class="flex items-center gap-1.5 text-masjid-text-muted">
                    <PhEnvelope :size="14" class="flex-shrink-0" />
                    <span class="truncate">{{ official.email }}</span>
                  </div>
                  <p v-if="!official.phone && !official.email" class="text-sm text-gray-400">-</p>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span
                  :class="`px-3 py-1 rounded-full text-xs font-medium ${
                    official.is_active
                      ? 'bg-green-100 text-green-700'
                      : 'bg-gray-100 text-gray-700'
                  }`"
                >
                  {{ official.is_active ? 'Aktif' : 'Non-Aktif' }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                <div class="flex items-center justify-end gap-3">
                  <NuxtLink
                    :to="`/admin/officials/edit/${official.id}`"
                    class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors"
                    title="Edit"
                  >
                    <PhPencil :size="18" />
                  </NuxtLink>
                  <button
                    @click="confirmDelete(official)"
                    class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                    title="Hapus"
                  >
                    <PhTrash :size="18" />
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div
      v-if="showDeleteModal"
      class="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4"
      @click.self="showDeleteModal = false"
    >
      <div class="bg-white rounded-xl p-6 max-w-md w-full shadow-2xl">
        <div class="text-center mb-6">
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-red-100 mb-4">
            <PhWarning :size="32" class="text-red-600" />
          </div>
          <h3 class="text-xl font-serif font-bold text-masjid-dark mb-2">
            Hapus Pengurus?
          </h3>
          <p class="text-masjid-text-muted">
            Apakah Anda yakin ingin menghapus "<strong>{{ officialToDelete?.name }}</strong>"? Tindakan ini tidak dapat dibatalkan.
          </p>
        </div>
        <div class="flex gap-3">
          <button
            @click="showDeleteModal = false"
            class="flex-1 px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-700 font-medium rounded-lg transition-colors"
          >
            Batal
          </button>
          <button
            @click="handleDelete"
            :disabled="deleting"
            class="flex-1 px-4 py-2 bg-red-600 hover:bg-red-700 text-white font-medium rounded-lg transition-colors disabled:opacity-50"
          >
            {{ deleting ? 'Menghapus...' : 'Hapus' }}
          </button>
        </div>
      </div>
    </div>
  </div>
  </NuxtLayout>
</template>

<script setup lang="ts">
import { PhPlus, PhUsers, PhUser, PhPhone, PhEnvelope, PhPencil, PhTrash, PhWarning } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const { fetchOfficials, deleteOfficial, deleteOfficialPhoto } = useOfficials()
const toast = useToast()

const officials = ref<any[]>([])
const loading = ref(true)
const showDeleteModal = ref(false)
const officialToDelete = ref<any>(null)
const deleting = ref(false)

const loadOfficials = async () => {
  loading.value = true
  try {
    officials.value = await fetchOfficials(true) // Include inactive
  } catch (error) {
    console.error('Error loading officials:', error)
    toast.error('Gagal memuat data pengurus')
  } finally {
    loading.value = false
  }
}

const confirmDelete = (official: any) => {
  officialToDelete.value = official
  showDeleteModal.value = true
}

const handleDelete = async () => {
  if (!officialToDelete.value) return

  deleting.value = true
  try {
    // Delete photo if exists
    if (officialToDelete.value.photo_url) {
      await deleteOfficialPhoto(officialToDelete.value.photo_url)
    }

    // Delete official
    await deleteOfficial(officialToDelete.value.id)

    toast.success('Pengurus berhasil dihapus')

    // Reload list
    await loadOfficials()

    showDeleteModal.value = false
    officialToDelete.value = null
  } catch (error) {
    console.error('Error deleting official:', error)
    toast.error('Gagal menghapus pengurus')
  } finally {
    deleting.value = false
  }
}

onMounted(() => {
  loadOfficials()
})
</script>
