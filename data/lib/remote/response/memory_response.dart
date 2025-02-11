class MemoryResponse {
  final int id;
  final String imagePath;
  final String uploadedBy;

  MemoryResponse({
    required this.id,
    required this.imagePath,
    required this.uploadedBy,
  });

  factory MemoryResponse.fromJson(Map<String, dynamic> json) {
    return MemoryResponse(
      id: json['id'] as int,
      imagePath: json['image_path'],
      uploadedBy: json['uploaded_by'],
    );
  }
}
