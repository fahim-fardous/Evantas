import 'dart:io';

import 'package:data/mapper/memory_mapper.dart';
import 'package:data/service/supabase_service.dart';
import 'package:domain/repository/memory_repository.dart';

class MemoryRepositoryImpl extends MemoryRepository {
  final SupabaseService supabaseService;

  MemoryRepositoryImpl({required this.supabaseService});

  @override
  Future<List<String>> getImages() async {
    final images = await supabaseService.getImages();

    if (images.isEmpty) {
      return [];
    }
    return images
        .map((image) => MemoryMapper.mapResponseToDomain(image).imagePath)
        .toList();
  }

  @override
  Future<void> saveImage(String imagePath) async {
    await supabaseService.saveImage(imagePath);
  }
}
