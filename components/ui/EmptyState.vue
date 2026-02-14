<template>
  <!-- Empty State Component -->
  <div class="text-center py-16 px-4">
    <div class="inline-flex items-center justify-center w-20 h-20 bg-gray-100 rounded-full mb-6">
      <span class="text-4xl">{{ icon }}</span>
    </div>
    
    <h3 class="text-xl font-serif font-bold text-masjid-dark mb-2">{{ title }}</h3>
    <p class="text-masjid-text-muted mb-6 max-w-md mx-auto">{{ message }}</p>
    
    <slot name="action">
      <NuxtLink
        v-if="actionUrl"
        :to="actionUrl"
        class="inline-flex items-center gap-2 px-6 py-3 bg-masjid-gold hover:bg-masjid-dark text-white font-medium rounded-lg transition-colors"
      >
        {{ actionText }}
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
        </svg>
      </NuxtLink>
    </slot>
  </div>
</template>

<script setup lang="ts">
interface Props {
  icon?: string
  title: string
  message: string
  actionText?: string
  actionUrl?: string
}

withDefaults(defineProps<Props>(), {
  icon: '📭',
  actionText: 'Kembali'
})
</script>
