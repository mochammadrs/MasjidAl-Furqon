<template>
  <div>
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
    <!-- Global Toast Notifications -->
    <UiToastContainer />
  </div>
</template>

<script setup lang="ts">
// Global scroll animation setup dengan berbagai variasi
onMounted(() => {
  // Definisi animasi untuk tiap section
  const sectionAnimations: Record<string, string> = {
    'jadwal-sholat': 'animate-fade-in',
    'tentang': 'animate-slide-in-left',
    'kegiatan': 'animate-slide-in-right',
    'donasi': 'animate-zoom-in',
    'pengurus': 'animate-slide-in-left',
    'galeri': 'animate-slide-in-right'
  }
  
  const sections = document.querySelectorAll('section[id]')
  
  const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -80px 0px'
  }
  
  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        const sectionId = entry.target.id
        const animationClass = sectionAnimations[sectionId] || 'animate-fade-in-up'
        entry.target.classList.add(animationClass)
        observer.unobserve(entry.target)
      }
    })
  }, observerOptions)
  
  sections.forEach((section) => {
    section.classList.add('opacity-0')
    observer.observe(section)
  })
})
</script>

<style>
/* Global animations dengan berbagai variasi */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(40px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes slideInLeft {
  from {
    opacity: 0;
    transform: translateX(-60px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes slideInRight {
  from {
    opacity: 0;
    transform: translateX(60px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes zoomIn {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.animate-fade-in-up {
  animation: fadeInUp 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
}

.animate-fade-in {
  animation: fadeIn 0.8s ease-out forwards;
}

.animate-slide-in-left {
  animation: slideInLeft 0.9s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
}

.animate-slide-in-right {
  animation: slideInRight 0.9s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
}

.animate-zoom-in {
  animation: zoomIn 0.8s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
}
</style>
