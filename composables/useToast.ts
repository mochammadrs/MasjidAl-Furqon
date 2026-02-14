// Toast Notification Composable
// Usage: const toast = useToast()
//        toast.success('Data berhasil disimpan!')

export interface Toast {
  id: string
  type: 'success' | 'error' | 'warning' | 'info'
  message: string
  duration: number
}

const toasts = ref<Toast[]>([])

export const useToast = () => {
  const add = (toast: Omit<Toast, 'id'>) => {
    const id = Math.random().toString(36).substring(7)
    const newToast: Toast = { ...toast, id }
    
    toasts.value.push(newToast)

    // Auto remove after duration
    if (toast.duration > 0) {
      setTimeout(() => {
        remove(id)
      }, toast.duration)
    }
  }

  const remove = (id: string) => {
    const index = toasts.value.findIndex(t => t.id === id)
    if (index > -1) {
      toasts.value.splice(index, 1)
    }
  }

  const success = (message: string, duration = 3000) => {
    add({ type: 'success', message, duration })
  }

  const error = (message: string, duration = 4000) => {
    add({ type: 'error', message, duration })
  }

  const warning = (message: string, duration = 3000) => {
    add({ type: 'warning', message, duration })
  }

  const info = (message: string, duration = 3000) => {
    add({ type: 'info', message, duration })
  }

  const clear = () => {
    toasts.value = []
  }

  return {
    toasts: readonly(toasts),
    add,
    remove,
    success,
    error,
    warning,
    info,
    clear
  }
}
