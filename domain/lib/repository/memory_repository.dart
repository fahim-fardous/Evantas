import 'dart:io';

abstract class MemoryRepository {
  Future<void> saveImage(String imagePath);

  Future<List<String>> getImages();
}