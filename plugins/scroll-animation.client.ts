export default defineNuxtPlugin((nuxtApp) => {
  // Directive untuk scroll animation
  nuxtApp.vueApp.directive('scroll-animate', {
    mounted(el, binding) {
      // Dapatkan direction dari binding value, default 'left'
      const direction = binding.value || 'left'
      
      // Set initial state (hidden)
      el.classList.add('scroll-animate-hidden')
      el.classList.add(`scroll-animate-${direction}`)
      
      // Intersection Observer options
      const options = {
        threshold: 0.15, // Trigger saat 15% element terlihat
        rootMargin: '0px 0px -50px 0px' // Offset dari bawah viewport
      }
      
      // Create observer
      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            // Add visible class untuk trigger animation
            entry.target.classList.add('scroll-animate-visible')
            // Optional: unobserve setelah animation trigger (animasi sekali saja)
            observer.unobserve(entry.target)
          }
        })
      }, options)
      
      // Start observing
      observer.observe(el)
      
      // Cleanup function
      el._scrollAnimationObserver = observer
    },
    
    unmounted(el) {
      // Cleanup observer saat component unmounted
      if (el._scrollAnimationObserver) {
        el._scrollAnimationObserver.disconnect()
      }
    }
  })
})
