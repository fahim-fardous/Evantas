import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MemoryRepository {
  Future<void> uploadPhoto(File file, String fileName);
  Future<void> deletePhoto(String fileName);

  Future<List<FileObject>> fetchImages();
}