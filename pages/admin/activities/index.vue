<template>
  <div class="space-y-6">
      <!-- Add Button -->
    <div class="flex justify-end">
      <NuxtLink
        to="/admin/activities/new"
        class="px-4 py-2.5 bg-masjid-gold hover:bg-masjid-dark text-white font-semibold rounded-lg transition-all duration-300 flex items-center gap-2 shadow-md hover:shadow-lg"
      >
        <PhPlus :size="18" />
        <span>Tambah Kegiatan</span>
      </NuxtLink>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex justify-center py-12">
      <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-masjid-gold"></div>
    </div>

    <!-- Activities Table -->
    <div v-else class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
      <div v-if="activities.length === 0" class="text-center py-16">
        <div class="inline-flex items-center justify-center w-20 h-20 rounded-2xl bg-gray-100 mb-5">  
          <PhCalendar :size="40" class="text-gray-400" />
        </div>
        <p class="text-masjid-text-muted mb-6 text-lg">Belum ada kegiatan</p>
        <NuxtLink
          to="/admin/activities/new"
          class="inline-flex items-center gap-2 px-5 py-2.5 bg-masjid-gold hover:bg-masjid-dark text-white font-semibold rounded-lg transition-all duration-300"
        >
          <PhPlus :size="18" />
          <span>Tambah Kegiatan Pertama</span>
        </NuxtLink>
      </div>

      <div v-else class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-gray-50 border-b border-gray-200">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Kegiatan
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Tanggal & Waktu
              </th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Kategori
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
              v-for="activity in activities"
              :key="activity.id"
              class="hover:bg-gray-50 transition-colors"
            >
              <td class="px-6 py-4">
                <div class="flex items-start gap-3">
                  <div
                    v-if="activity.image_url"
                    class="w-16 h-16 rounded-lg overflow-hidden flex-shrink-0"
                  >
                    <img :src="activity.image_url" :alt="activity.title" class="w-full h-full object-cover" loading="lazy" decoding="async" />
                  </div>
                  <div
                    v-else
                    class="w-16 h-16 rounded-lg bg-gradient-to-br from-gray-100 to-gray-50 flex items-center justify-center flex-shrink-0"
                  >
                    <PhCalendar :size="28" class="text-gray-400" />
                  </div>
                  <div class="min-w-0 flex-1">
                    <p class="font-medium text-masjid-dark">{{ activity.title }}</p>
                    <p class="text-sm text-masjid-text-muted truncate">{{ activity.description }}</p>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm">
                  <p class="font-medium text-masjid-dark">{{ formatDate(activity.date) }}</p>
                  <p class="text-masjid-text-muted">{{ activity.time || '-' }}</p>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span :class="`px-3 py-1 rounded-full text-xs font-medium ${getCategoryColor(activity.category)}`">
                  {{ activity.category }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span
                  :class="`px-3 py-1 rounded-full text-xs font-medium ${
                    activity.is_published
                      ? 'bg-green-100 text-green-700'
                      : 'bg-gray-100 text-gray-700'
                  }`"
                >
                  {{ activity.is_published ? 'Published' : 'Draft' }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                <div class="flex items-center justify-end gap-3">
                  <NuxtLink
                    :to="`/admin/activities/edit/${activity.id}`"
                    class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors"
                    title="Edit"
                  >
                    <PhPencil :size="18" />
                  </NuxtLink>
                  <button
                    @click="confirmDelete(activity)"
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
            Hapus Kegiatan?
          </h3>
          <p class="text-masjid-text-muted leading-relaxed">
            Apakah Anda yakin ingin menghapus "<strong>{{ activityToDelete?.title }}</strong>"? Tindakan ini tidak dapat dibatalkan.
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
</template>

<script setup lang="ts">
import { PhPlus, PhCalendar, PhPencil, PhTrash, PhWarning } from '@phosphor-icons/vue'

definePageMeta({
  layout: 'admin',
  middleware: 'auth'
})

const { fetchActivities, deleteActivity, deleteActivityImage } = useActivities()
const toast = useToast()

const activities = ref<any[]>([])
const loading = ref(true)
const showDeleteModal = ref(false)
const activityToDelete = ref<any>(null)
const deleting = ref(false)

const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return new Intl.DateTimeFormat('id-ID', {
    day: 'numeric',
    month: 'long',
    year: 'numeric'
  }).format(date)
}

const getCategoryColor = (category: string) => {
  const colors: Record<string, string> = {
    kajian: 'bg-blue-100 text-blue-700',
    sosial: 'bg-green-100 text-green-700',
    pendidikan: 'bg-purple-100 text-purple-700',
    ramadhan: 'bg-yellow-100 text-yellow-700',
    lainnya: 'bg-gray-100 text-gray-700'
  }
  return colors[category] || colors.lainnya
}

const loadActivities = async () => {
  loading.value = true
  try {
    activities.value = await fetchActivities(true)
  } catch (error) {
    console.error('Error loading activities:', error)
    toast.error('Gagal memuat data kegiatan')
  } finally {
    loading.value = false
  }
}

const confirmDelete = (activity: any) => {
  activityToDelete.value = activity
  showDeleteModal.value = true
}

const handleDelete = async () => {
  if (!activityToDelete.value) return

  deleting.value = true
  try {
    // Delete image if exists
    if (activityToDelete.value.image_url) {
      await deleteActivityImage(activityToDelete.value.image_url)
    }

    // Delete activity
    await deleteActivity(activityToDelete.value.id)

    // Show success message
    toast.success('Kegiatan berhasil dihapus')

    // Reload list
    await loadActivities()

    showDeleteModal.value = false
    activityToDelete.value = null
  } catch (error) {
    console.error('Error deleting activity:', error)
    toast.error('Gagal menghapus kegiatan')
  } finally {
    deleting.value = false
  }
}

onMounted(() => {
  loadActivities()
})
</script>
