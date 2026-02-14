-- =====================================================
-- TAMBAH FIELD VISI MISI KE SETTINGS TABLE
-- Jalankan SQL ini di Supabase SQL Editor
-- =====================================================

-- Insert default visi misi settings
INSERT INTO settings (key, value, description) VALUES
  (
    'masjid_visi', 
    'Menjadi masjid yang maju, mandiri, dan berkontribusi dalam pembinaan umat yang berakhlakul karimah, berilmu, dan peduli terhadap sesama.',
    'Visi masjid yang akan ditampilkan di section Visi Misi'
  ),
  (
    'masjid_misi',
    'Menyelenggarakan kegiatan dakwah dan pendidikan Islam yang berkualitas
Membina generasi Qurani melalui program tahfizh dan kajian rutin
Mengembangkan ekonomi umat melalui program sosial dan pemberdayaan
Membangun ukhuwah Islamiyah dan kepedulian sosial
Mengelola masjid secara transparan, amanah, dan profesional',
    'Misi masjid yang akan ditampilkan di section Visi Misi (pisahkan dengan enter untuk list)'
  )
ON CONFLICT (key) DO NOTHING;

-- =====================================================
-- SELESAI!
-- =====================================================
-- Silakan edit visi misi di /admin/settings
-- Untuk misi, pisahkan tiap poin dengan enter/baris baru
