export const useScrollAnimation = (direction: 'left' | 'right' | 'up' = 'left') => {
  const elementRef = ref<HTMLElement | null>(null)

  onMounted(() => {
    if (!elementRef.value) return

    const element = elementRef.value

    // Set initial state
    element.classList.add('scroll-animate-hidden', `scroll-animate-${direction}`)

    // Intersection Observer options
    const options = {
      threshold: 0.15,
      rootMargin: '0px 0px -50px 0px'
    }

    // Create observer
    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('scroll-animate-visible')
          observer.unobserve(entry.target)
        }
      })
    }, options)

    observer.observe(element)

    // Cleanup
    onUnmounted(() => {
      observer.disconnect()
    })
  })

  return { elementRef }
}
