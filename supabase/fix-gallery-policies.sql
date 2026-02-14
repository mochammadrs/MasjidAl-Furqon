-- =====================================================
-- FIX GALLERY RLS POLICIES
-- Jalankan SQL ini di Supabase SQL Editor
-- =====================================================

-- Drop existing policies
DROP POLICY IF EXISTS "Admin can insert gallery" ON gallery;
DROP POLICY IF EXISTS "Admin can update gallery" ON gallery;
DROP POLICY IF EXISTS "Admin can delete gallery" ON gallery;
DROP POLICY IF EXISTS "Public can view gallery" ON gallery;

-- Public dapat melihat semua gallery
CREATE POLICY "Public can view gallery"
  ON gallery FOR SELECT
  USING (true);

-- Authenticated admin dapat INSERT
CREATE POLICY "Admin can insert gallery"
  ON gallery FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Authenticated admin dapat UPDATE
CREATE POLICY "Admin can update gallery"
  ON gallery FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Authenticated admin dapat DELETE
CREATE POLICY "Admin can delete gallery"
  ON gallery FOR DELETE
  TO authenticated
  USING (true);

-- =====================================================
-- SELESAI! 
-- =====================================================
-- Gallery policies sudah aktif
-- Storage policies sudah ada dari fix sebelumnya
-- Folder 'gallery' harus sudah dibuat di Storage bucket 'photos'
