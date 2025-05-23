import 'dart:io';

import 'package:data/service/supabase_service.dart';
import 'package:domain/repository/memory_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MemoryRepositoryImpl extends MemoryRepository {
  final SupabaseService supabaseService;

  MemoryRepositoryImpl({required this.supabaseService});

  @override
  Future<void> uploadPhoto(source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        final File file = File(image.path);
        final String fileName = "${DateTime.now().microsecondsSinceEpoch}.jpg";

        await supabaseService.supabaseClient.storage.from('photos').upload(
              fileName,
              file,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: false,
              ),
            );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FileObject>> fetchImages() async{
    try {
      final response = await supabaseService.supabaseClient.storage.from('photos').list();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePhoto(String fileName) async {
    await supabaseService.deletePhoto(fileName);
  }
}
