-- =====================================================
-- FIX GALLERY TABLE - Allow NULL image_url
-- Jalankan SQL ini di Supabase SQL Editor
-- =====================================================

-- Alter table gallery agar image_url bisa NULL
ALTER TABLE gallery 
ALTER COLUMN image_url DROP NOT NULL;

-- Sekarang image_url bisa NULL saat create record
-- Foto akan diupload setelah record dibuat

-- =====================================================
-- SELESAI! 
-- =====================================================
-- Sekarang upload foto gallery akan berhasil
