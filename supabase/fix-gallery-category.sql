-- =====================================================
-- FIX GALLERY CATEGORY CONSTRAINT
-- Jalankan SQL ini di Supabase SQL Editor
-- =====================================================

-- Drop constraint lama
ALTER TABLE gallery 
DROP CONSTRAINT IF EXISTS gallery_category_check;

-- Buat constraint baru dengan kategori yang benar
ALTER TABLE gallery
ADD CONSTRAINT gallery_category_check 
CHECK (category IN ('kegiatan', 'masjid', 'jamaah', 'lainnya'));

-- =====================================================
-- SELESAI! 
-- =====================================================
-- Kategori yang valid sekarang:
-- - kegiatan
-- - masjid  
-- - jamaah
-- - lainnya
