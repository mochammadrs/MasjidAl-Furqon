-- =====================================================
-- FIX OFFICIALS RLS & STORAGE POLICIES
-- Jalankan SQL ini di Supabase SQL Editor
-- =====================================================

-- 1. Fix RLS policies untuk tabel officials
DROP POLICY IF EXISTS "Admin can insert officials" ON officials;
DROP POLICY IF EXISTS "Admin can update officials" ON officials;
DROP POLICY IF EXISTS "Admin can delete officials" ON officials;
DROP POLICY IF EXISTS "Public can view officials" ON officials;

-- Public dapat melihat officials yang aktif
CREATE POLICY "Public can view officials"
  ON officials FOR SELECT
  USING (true);

-- Authenticated admin dapat INSERT
CREATE POLICY "Admin can insert officials"
  ON officials FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Authenticated admin dapat UPDATE
CREATE POLICY "Admin can update officials"
  ON officials FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Authenticated admin dapat DELETE
CREATE POLICY "Admin can delete officials"
  ON officials FOR DELETE
  TO authenticated
  USING (true);

-- 2. Pastikan storage policies sudah aktif
-- Drop existing storage policies (jika ada masalah)
DROP POLICY IF EXISTS "Public can view photos" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can upload photos" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can update photos" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can delete photos" ON storage.objects;

-- Recreate storage policies
CREATE POLICY "Public can view photos"
ON storage.objects FOR SELECT
USING (bucket_id = 'photos');

CREATE POLICY "Authenticated users can upload photos"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'photos');

CREATE POLICY "Authenticated users can update photos"
ON storage.objects FOR UPDATE
TO authenticated
USING (bucket_id = 'photos')
WITH CHECK (bucket_id = 'photos');

CREATE POLICY "Authenticated users can delete photos"
ON storage.objects FOR DELETE
TO authenticated
USING (bucket_id = 'photos');

-- =====================================================
-- SELESAI! 
-- =====================================================
-- Silakan coba upload foto pengurus lagi
