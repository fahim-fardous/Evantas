import 'package:data/remote/response/memory_response.dart';
import 'package:domain/model/memory.dart';

class MemoryMapper {
  static Memory mapResponseToDomain(MemoryResponse response) {
    return Memory(
      id: response.id,
      imagePath: response.imagePath,
      uploadedBy: response.uploadedBy,
    );
  }
}
