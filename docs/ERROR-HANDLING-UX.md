# Error Handling & UX - Sprint 3

## ✅ Sudah Diimplementasi

### 1. Custom 404 Error Page
**File:** `error.vue`

**Features:**
- ✅ Beautiful 404 design dengan ilustrasi masjid
- ✅ Quick navigation links (Beranda, Kegiatan, Donasi, WhatsApp)
- ✅ Back button & Home button
- ✅ SEO meta dengan noindex (tidak masuk Google)
- ✅ Responsive design

**Test:**
```
http://localhost:3000/halaman-tidak-ada
http://localhost:3000/random-url-123
```

---

### 2. Loading Skeleton Components
**Location:** `components/skeleton/`

#### A. ActivityCardSkeleton.vue
- Menampilkan placeholder saat loading kegiatan
- Animasi pulse untuk shimmer effect
- Match exact design dengan activity card

#### B. OfficialCardSkeleton.vue
- Skeleton untuk card pengurus
- Aspect square image placeholder
- Text line skeletons

#### C. GalleryImageSkeleton.vue
- Simple aspect-square skeleton untuk gallery
- Rounded corners matching design

#### D. PrayerCardSkeleton.vue
- Skeleton untuk card jadwal sholat
- Icon, name, time placeholders

**Usage:**
```vue
<template>
  <!-- While loading -->
  <SkeletonActivityCardSkeleton v-if="loading" />
  
  <!-- After loaded -->
  <ActivityCard v-else :activity="data" />
</template>
```

---

### 3. Toast Notification System
**Files:**
- `composables/useToast.ts` - Toast logic
- `components/ui/ToastContainer.vue` - Toast UI
- `app.vue` - Global injection

**Features:**
- ✅ 4 types: success, error, warning, info
- ✅ Auto-dismiss dengan custom duration
- ✅ Manual close button
- ✅ Smooth slide-in animation dari kanan
- ✅ Stack multiple toasts
- ✅ Global accessible dari anywhere

**Usage Examples:**

```typescript
// In any component or page
const toast = useToast()

// Success toast (3s auto-dismiss)
toast.success('Data berhasil disimpan!')

// Error toast (4s auto-dismiss)
toast.error('Gagal menghapus data')

// Warning toast
toast.warning('Anda belum melengkapi form')

// Info toast
toast.info('Refresh halaman untuk melihat perubahan')

// Custom duration
toast.success('Uploaded!', 5000) // 5 seconds
```

**Recommended Usage:**
```typescript
// Example: After submitting form
const handleSubmit = async () => {
  try {
    await someAPI()
    toast.success('✅ Kegiatan berhasil dibuat!')
  } catch (error) {
    toast.error('❌ Gagal membuat kegiatan')
  }
}
```

---

### 4. Error Fallback UI
**File:** `components/ui/ErrorFallback.vue`

**Features:**
- Red-themed error card dengan icon
- Customizable title & message
- Optional retry button dengan emit event
- Consistent design dengan website branding

**Props:**
```typescript
{
  title: string     // Default: "Terjadi Kesalahan"
  message: string   // Default: "Maaf, terjadi kesalahan..."
  showRetry: boolean // Default: true
}
```

**Usage:**
```vue
<template>
  <UiErrorFallback
    v-if="error"
    title="Gagal Memuat Data"
    message="Koneksi ke server terputus. Silakan coba lagi."
    @retry="loadData"
  />
</template>
```

---

### 5. Empty State Component
**File:** `components/ui/EmptyState.vue`

**Features:**
- Centered layout dengan icon besar
- Custom emoji/icon support
- Title & message customizable
- Optional action button dengan link
- Slot untuk custom action

**Props:**
```typescript
{
  icon: string       // Default: "📭"
  title: string      // Required
  message: string    // Required
  actionText: string // Default: "Kembali"
  actionUrl: string  // Optional
}
```

**Usage Examples:**

```vue
<!-- No data found -->
<UiEmptyState
  icon="📅"
  title="Belum Ada Kegiatan"
  message="Belum ada kegiatan yang dijadwalkan untuk bulan ini."
  actionText="Lihat Arsip"
  actionUrl="/kegiatan/arsip"
/>

<!-- With custom action -->
<UiEmptyState
  icon="🔍"
  title="Tidak Ada Hasil"
  message="Pencarian Anda tidak ditemukan."
>
  <template #action>
    <button @click="resetSearch">
      Reset Pencarian
    </button>
  </template>
</UiEmptyState>
```

---

## 🎯 Implementation Checklist

### A. Update Admin Pages (RECOMMENDED)

**pages/admin/settings.vue:**
```typescript
// Replace current success/error messages
const handleSubmit = async () => {
  try {
    await updateSettings(...)
    toast.success('✅ Pengaturan berhasil disimpan!')
  } catch (err) {
    toast.error('❌ Gagal menyimpan pengaturan')
  }
}
```

**pages/admin/activities/new.vue:**
```typescript
const handleSubmit = async () => {
  try {
    await createActivity(...)
    toast.success('✅ Kegiatan berhasil dibuat!')
    router.push('/admin/activities')
  } catch (err) {
    toast.error('❌ Gagal membuat kegiatan')
  }
}
```

**pages/admin/activities/index.vue:**
```typescript
const deleteActivity = async (id: string) => {
  if (confirm('Yakin ingin menghapus?')) {
    try {
      await remove(id)
      toast.success('🗑️ Kegiatan berhasil dihapus!')
    } catch (err) {
      toast.error('❌ Gagal menghapus kegiatan')
    }
  }
}
```

### B. Update Public Sections (OPTIONAL)

**components/home/ActivitiesSection.vue:**
```vue
<!-- Replace spinner with skeleton -->
<div v-if="loading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
  <SkeletonActivityCardSkeleton v-for="n in 3" :key="n" />
</div>

<!-- Add error fallback -->
<UiErrorFallback
  v-else-if="error"
  title="Gagal Memuat Kegiatan"
  @retry="refetch"
/>

<!-- Add empty state -->
<UiEmptyState
  v-else-if="activities.length === 0"
  icon="📅"
  title="Belum Ada Kegiatan"
  message="Belum ada kegiatan yang dijadwalkan."
/>

<!-- Normal content -->
<div v-else class="grid...">
  <!-- Activities -->
</div>
```

**Similar pattern untuk:**
- `components/home/OfficialsSection.vue`
- `components/home/GallerySection.vue`
- `components/prayer/PrayerWidget.vue`

---

## 📊 UX Improvements Summary

| Feature | Before | After | Impact |
|---------|--------|-------|--------|
| 404 Page | Generic Nuxt error | Custom with navigation | High - Better UX |
| Loading States | Spinner only | Skeleton + shimmer | High - Perceived speed |
| Success/Error | Text alerts | Toast notifications | High - Modern UX |
| Error Handling | None | Fallback + retry | Medium - Reliability |
| Empty States | Text only | Component with icon | Medium - Visual clarity |

---

## 🧪 Testing Guide

### 1. Test 404 Page
```bash
# Visit non-existent URLs
http://localhost:3000/random-page
http://localhost:3000/admin/xyz
http://localhost:3000/kegiatan/999

# Expected: Custom 404 page dengan quick links
```

### 2. Test Toast Notifications
```javascript
// Open browser console di halaman mana saja
const toast = useToast()
toast.success('Test success!')
toast.error('Test error!')
toast.warning('Test warning!')
toast.info('Test info!')
```

### 3. Test Loading Skeletons
```vue
<!-- Temporarily add delay untuk test -->
<SkeletonActivityCardSkeleton v-for="n in 3" :key="n" />
```

### 4. Test Error Fallback
```vue
<!-- Simulate error state -->
<UiErrorFallback @retry="console.log('Retry clicked')" />
```

### 5. Test Empty State
```vue
<!-- Simulate empty data -->
<UiEmptyState
  title="Test Empty"
  message="No data found"
/>
```

---

## 🚀 Next Implementation (Recommended)

### Priority 1: Update Admin Pages
- [x] Create toast composable
- [x] Create toast container
- [ ] Update settings.vue dengan toast
- [ ] Update activities CRUD dengan toast
- [ ] Update officials CRUD dengan toast
- [ ] Update gallery CRUD dengan toast

### Priority 2: Update Public Sections
- [ ] ActivitiesSection: skeleton + error + empty
- [ ] OfficialsSection: skeleton + error + empty
- [ ] GallerySection: skeleton + error + empty
- [ ] PrayerWidget: skeleton + error

### Priority 3: Polish
- [ ] Add loading states saat upload foto
- [ ] Add progress indicator untuk long operations
- [ ] Test semua error scenarios
- [ ] Accessibility improvements (ARIA labels)

---

## 💡 Best Practices

### Toast Notifications:
```typescript
// ✅ Good - Clear & concise
toast.success('Data berhasil disimpan!')

// ❌ Bad - Too long
toast.success('Data Anda telah berhasil disimpan ke dalam database dan akan segera muncul di halaman utama')
```

### Error Messages:
```typescript
// ✅ Good - Actionable
toast.error('Koneksi gagal. Periksa internet Anda.')

// ❌ Bad - Technical jargon
toast.error('ERR_CONNECTION_REFUSED: 500 Internal Server Error')
```

### Loading States:
```vue
<!-- ✅ Good - Show skeleton structure -->
<SkeletonActivityCardSkeleton v-if="loading" />

<!-- ❌ Bad - Generic spinner everywhere -->
<div v-if="loading">Loading...</div>
```

---

**Sprint 3 Error Handling & UX: COMPLETE!** 🎉

**Files Created:**
- ✅ error.vue (404 page)
- ✅ 4 skeleton components
- ✅ useToast composable
- ✅ ToastContainer component
- ✅ ErrorFallback component
- ✅ EmptyState component
- ✅ app.vue updated (toast injection)

**Ready for:**
- Implementation in admin pages ✨
- Implementation in public sections ✨
- Performance optimization next! 🚀
