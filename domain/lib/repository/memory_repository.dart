import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MemoryRepository {
  Future<void> uploadPhoto(ImageSource source);
  Future<void> deletePhoto(String fileName);

  Future<List<FileObject>> fetchImages();
}