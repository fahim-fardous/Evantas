import 'dart:io';

import 'package:data/service/supabase_service.dart';
import 'package:domain/repository/memory_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MemoryRepositoryImpl extends MemoryRepository {
  final SupabaseService supabaseService;

  MemoryRepositoryImpl({required this.supabaseService});

  @override
  Future<void> uploadPhoto(File file, String fileName) async {
    try {
      await supabaseService.uploadPhoto(file, fileName);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FileObject>> fetchImages() async {
    try {
      final response =
          await supabaseService.fetchImages();
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
