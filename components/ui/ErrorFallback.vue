<template>
  <!-- Error Fallback Card -->
  <div class="bg-red-50 border border-red-200 rounded-xl p-8 text-center">
    <div class="inline-flex items-center justify-center w-16 h-16 bg-red-100 rounded-full mb-4">
      <svg class="w-8 h-8 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
      </svg>
    </div>
    
    <h3 class="text-lg font-bold text-red-900 mb-2">{{ title }}</h3>
    <p class="text-sm text-red-700 mb-6">{{ message }}</p>
    
    <button
      v-if="showRetry"
      @click="$emit('retry')"
      class="px-6 py-2.5 bg-red-600 hover:bg-red-700 text-white font-medium rounded-lg transition-colors inline-flex items-center gap-2"
    >
      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
      </svg>
      Coba Lagi
    </button>
  </div>
</template>

<script setup lang="ts">
interface Props {
  title?: string
  message?: string
  showRetry?: boolean
}

withDefaults(defineProps<Props>(), {
  title: 'Terjadi Kesalahan',
  message: 'Maaf, terjadi kesalahan saat memuat data. Silakan coba lagi.',
  showRetry: true
})

defineEmits<{
  retry: []
}>()
</script>
