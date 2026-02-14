<template>
  <nav class="sticky top-0 z-50 bg-white shadow-md">
    <div class="container mx-auto px-4 lg:px-8">
      <div class="flex items-center justify-between h-20">
        <!-- Logo -->
        <a href="/" @click="handleLogoClick" class="flex items-center gap-2 lg:gap-3 group flex-shrink-0 cursor-pointer">
          <div class="w-10 h-10 sm:w-12 sm:h-12 rounded-lg bg-white shadow-md flex items-center justify-center overflow-hidden">
            <img src="/images/logo-masjid.png" alt="Logo Masjid Al-Furqon" class="w-full h-full object-cover" />
          </div>
          <div>
            <h1 class="text-sm sm:text-base lg:text-lg font-serif font-bold text-masjid-dark leading-tight">
              Masjid Al-Furqon
            </h1>
            <p class="text-[10px] sm:text-xs lg:text-sm text-masjid-text-muted leading-tight">
              Perumahan Bukit Rancapaku Indah
            </p>
          </div>
        </a>

        <!-- Desktop Menu -->
        <div class="hidden md:flex items-center gap-8">
          <NuxtLink
            v-for="item in menuItems"
            :key="item.name"
            :to="item.path"
            @click="(e) => handleSmoothScroll(e, item.path)"
            class="text-sm font-medium text-masjid-dark hover:text-masjid-gold transition-colors duration-200"
          >
            {{ item.name }}
          </NuxtLink>
          
          <NuxtLink
            to="/admin/login"
            class="px-5 py-2.5 bg-masjid-gold text-white rounded-lg text-sm font-medium hover:bg-masjid-dark transition-all duration-200 shadow-sm hover:shadow-md"
          >
            Admin
          </NuxtLink>
        </div>

        <!-- Mobile Menu Button -->
        <button
          @click="mobileMenuOpen = !mobileMenuOpen"
          class="md:hidden p-2 rounded-lg hover:bg-gray-100 transition-colors"
          aria-label="Toggle menu"
        >
          <svg
            class="w-6 h-6 text-masjid-dark"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              v-if="!mobileMenuOpen"
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M4 6h16M4 12h16M4 18h16"
            />
            <path
              v-else
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M6 18L18 6M6 6l12 12"
            />
          </svg>
        </button>
      </div>

      <!-- Mobile Menu -->
      <Transition
        enter-active-class="transition-all duration-300 ease-out"
        enter-from-class="transform opacity-0 -translate-y-2"
        enter-to-class="transform opacity-100 translate-y-0"
        leave-active-class="transition-all duration-200 ease-in"
        leave-from-class="transform opacity-100 translate-y-0"
        leave-to-class="transform opacity-0 -translate-y-2"
      >
        <div v-if="mobileMenuOpen" class="md:hidden py-4 border-t border-masjid-border">
          <div class="flex flex-col gap-3">
            <NuxtLink
              v-for="item in menuItems"
              :key="item.name"
              :to="item.path"
              @click="(e) => handleSmoothScroll(e, item.path)"
              class="px-4 py-2.5 text-sm font-medium text-masjid-dark hover:bg-masjid-gold-light rounded-lg transition-colors"
            >
              {{ item.name }}
            </NuxtLink>
            <NuxtLink
              to="/admin/login"
              @click="mobileMenuOpen = false"
              class="mx-4 px-4 py-2.5 bg-masjid-gold text-white rounded-lg text-sm font-medium text-center hover:bg-masjid-dark transition-colors"
            >
              Admin
            </NuxtLink>
          </div>
        </div>
      </Transition>
    </div>
  </nav>
</template>

<script setup lang="ts">
const route = useRoute()
const router = useRouter()
const mobileMenuOpen = ref(false)

const menuItems = [
  { name: 'Beranda', path: '/' },
  { name: 'Tentang', path: '/#tentang' },
  { name: 'Kegiatan', path: '/#kegiatan' },
  { name: 'Donasi', path: '/#donasi' },
  { name: 'Pengurus', path: '/#pengurus' },
  { name: 'Galeri', path: '/#galeri' }
]

// Handle logo click - scroll to top on homepage, navigate otherwise
const handleLogoClick = (event: Event) => {
  if (route.path === '/') {
    event.preventDefault()
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    })
  }
  // Otherwise, let default navigation happen
}

// Smooth scroll handler untuk hash links - IMPROVED VERSION
const handleSmoothScroll = (event: Event, path: string) => {
  // Jika path adalah '/' (Beranda) dan sudah di homepage
  if (path === '/' && route.path === '/') {
    event.preventDefault()
    event.stopPropagation()
    
    // Close mobile menu
    if (mobileMenuOpen.value) {
      mobileMenuOpen.value = false
    }
    
    // Scroll to top
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    })
    return
  }
  
  // Jika hash link (/#tentang, /#kegiatan, etc)
  if (path.startsWith('/#')) {
    event.preventDefault()
    event.stopPropagation()
    
    const hash = path.substring(2) // Remove /#
    
    // Close mobile menu dulu
    if (mobileMenuOpen.value) {
      mobileMenuOpen.value = false
    }
    
    // Tunggu sebentar untuk smooth transition
    requestAnimationFrame(() => {
      const element = document.getElementById(hash)
      
      if (element) {
        const navbarHeight = 80
        const elementPosition = element.getBoundingClientRect().top
        const offsetPosition = elementPosition + window.scrollY - navbarHeight
        
        window.scrollTo({
          top: offsetPosition,
          behavior: 'smooth'
        })
      }
    })
  }
}

// Close mobile menu on route change
watch(() => mobileMenuOpen.value, (isOpen) => {
  if (isOpen) {
    document.body.style.overflow = 'hidden'
  } else {
    document.body.style.overflow = ''
  }
})

// Handle hash links on page load
onMounted(() => {
  // Jika URL ada hash, scroll ke section tersebut
  if (window.location.hash) {
    const hash = window.location.hash.substring(1)
    setTimeout(() => {
      const element = document.getElementById(hash)
      if (element) {
        const navbarHeight = 80
        const elementPosition = element.getBoundingClientRect().top
        const offsetPosition = elementPosition + window.scrollY - navbarHeight
        
        window.scrollTo({
          top: offsetPosition,
          behavior: 'smooth'
        })
      }
    }, 500)
  }
})

onUnmounted(() => {
  document.body.style.overflow = ''
})
</script>
