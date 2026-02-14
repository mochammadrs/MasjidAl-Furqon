<template>
  <!-- Activity Card Skeleton -->
  <div class="bg-white rounded-2xl shadow-lg overflow-hidden border border-masjid-border animate-pulse">
    <!-- Image Skeleton -->
    <div class="w-full h-48 bg-gray-200"></div>
    
    <!-- Content Skeleton -->
    <div class="p-6 space-y-4">
      <!-- Category Badge -->
      <div class="h-6 w-24 bg-gray-200 rounded-full"></div>
      
      <!-- Title -->
      <div class="h-6 bg-gray-200 rounded w-3/4"></div>
      
      <!-- Description -->
      <div class="space-y-2">
        <div class="h-4 bg-gray-200 rounded"></div>
        <div class="h-4 bg-gray-200 rounded w-5/6"></div>
      </div>
      
      <!-- Date & Location -->
      <div class="flex gap-4 pt-4">
        <div class="h-4 w-32 bg-gray-200 rounded"></div>
        <div class="h-4 w-40 bg-gray-200 rounded"></div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// No props needed - pure skeleton
</script>
