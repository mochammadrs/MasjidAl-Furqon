export interface PrayerTime {
  name: string
  time: string
  isNext: boolean
}

export const usePrayerTimes = () => {
  const prayerTimes = ref<PrayerTime[]>([])
  const nextPrayer = ref<string>('')
  const countdown = ref<string>('')
  const loading = ref(false)
  const error = ref<string | null>(null)

  // Tasikmalaya Kota ID untuk MyQuran API
  const KOTA_ID = '1209'

  const fetchPrayerTimes = async () => {
    loading.value = true
    error.value = null

    try {
      const now = new Date()
      const year = now.getFullYear()
      const month = String(now.getMonth() + 1).padStart(2, '0')
      const date = String(now.getDate()).padStart(2, '0')

      const response = await fetch(
        `https://api.myquran.com/v2/sholat/jadwal/${KOTA_ID}/${year}/${month}/${date}`
      )

      if (!response.ok) {
        throw new Error('Failed to fetch prayer times')
      }

      const data = await response.json()
      const jadwal = data.data.jadwal

      const times: PrayerTime[] = [
        { name: 'Subuh', time: jadwal.subuh, isNext: false },
        { name: 'Dzuhur', time: jadwal.dzuhur, isNext: false },
        { name: 'Ashar', time: jadwal.ashar, isNext: false },
        { name: 'Maghrib', time: jadwal.maghrib, isNext: false },
        { name: 'Isya', time: jadwal.isya, isNext: false }
      ]

      // Tentukan waktu sholat berikutnya
      const currentTime = now.getHours() * 60 + now.getMinutes()
      
      for (let i = 0; i < times.length; i++) {
        const time = times[i]
        if (!time) continue
        
        const [hours, minutes] = time.time.split(':').map(Number)
        if (hours === undefined || minutes === undefined) continue
        
        const prayerMinutes = hours * 60 + minutes

        if (currentTime < prayerMinutes) {
          time.isNext = true
          nextPrayer.value = time.name
          break
        }
      }

      // Jika semua waktu sudah lewat, set Subuh sebagai next
      if (!nextPrayer.value && times[0]) {
        times[0].isNext = true
        nextPrayer.value = times[0].name
      }

      prayerTimes.value = times
    } catch (err) {
      error.value = err instanceof Error ? err.message : 'Unknown error'
      console.error('Error fetching prayer times:', err)
    } finally {
      loading.value = false
    }
  }

  // Update countdown setiap detik
  const updateCountdown = () => {
    if (!prayerTimes.value.length) return

    const now = new Date()
    const nextTime = prayerTimes.value.find(p => p.isNext)
    
    if (!nextTime) return

    const [hours, minutes] = nextTime.time.split(':').map(Number)
    if (hours === undefined || minutes === undefined) return
    
    const prayerDate = new Date(now)
    prayerDate.setHours(hours, minutes, 0, 0)

    // Jika waktu sudah lewat hari ini, set ke besok
    if (prayerDate < now) {
      prayerDate.setDate(prayerDate.getDate() + 1)
    }

    const diff = prayerDate.getTime() - now.getTime()
    const hoursLeft = Math.floor(diff / (1000 * 60 * 60))
    const minutesLeft = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))
    const secondsLeft = Math.floor((diff % (1000 * 60)) / 1000)

    countdown.value = `${String(hoursLeft).padStart(2, '0')}:${String(minutesLeft).padStart(2, '0')}:${String(secondsLeft).padStart(2, '0')}`
  }

  onMounted(() => {
    fetchPrayerTimes()
    
    // Update countdown setiap detik
    const interval = setInterval(updateCountdown, 1000)
    
    // Update prayer times setiap jam
    const hourlyInterval = setInterval(fetchPrayerTimes, 3600000)

    onUnmounted(() => {
      clearInterval(interval)
      clearInterval(hourlyInterval)
    })
  })

  return {
    prayerTimes,
    nextPrayer,
    countdown,
    loading,
    error,
    refetch: fetchPrayerTimes
  }
}
