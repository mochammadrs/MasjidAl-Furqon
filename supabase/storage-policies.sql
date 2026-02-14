-- =====================================================
-- SETUP STORAGE BUCKET POLICIES
-- Jalankan SQL ini di Supabase SQL Editor setelah bucket dibuat
-- =====================================================

-- Create storage bucket if not exists (alternative: buat manual di dashboard)
-- Note: Ini mungkin error jika bucket sudah ada, itu normal

INSERT INTO storage.buckets (id, name, public)
VALUES ('photos', 'photos', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- Drop existing storage policies
DROP POLICY IF EXISTS "Public can view photos" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can upload photos" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can update photos" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can delete photos" ON storage.objects;

-- Allow public to READ/SELECT photos
CREATE POLICY "Public can view photos"
ON storage.objects FOR SELECT
USING (bucket_id = 'photos');

-- Allow authenticated users to INSERT photos
CREATE POLICY "Authenticated users can upload photos"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'photos');

-- Allow authenticated users to UPDATE photos
CREATE POLICY "Authenticated users can update photos"
ON storage.objects FOR UPDATE
TO authenticated
USING (bucket_id = 'photos');

-- Allow authenticated users to DELETE photos
CREATE POLICY "Authenticated users can delete photos"
ON storage.objects FOR DELETE
TO authenticated
USING (bucket_id = 'photos');

-- =====================================================
-- DONE! Storage policies configured
-- =====================================================
