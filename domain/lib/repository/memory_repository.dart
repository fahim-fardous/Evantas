import 'package:domain/model/memory.dart';

abstract class MemoryRepository {
  Future<void> saveImage(String imagePath);

  Future<List<Memory>> getImages();
}