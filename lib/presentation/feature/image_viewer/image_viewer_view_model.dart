import 'dart:io';

import 'package:domain/model/memory.dart';
import 'package:domain/repository/memory_repository.dart';
import 'package:evntas/presentation/util/file_downloader.dart';
import 'package:evntas/presentation/util/storage_permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/image_viewer/route/image_viewer_argument.dart';

class ImageViewerViewModel extends BaseViewModel<ImageViewerArgument> {
  final MemoryRepository memoryRepository;

  final ValueNotifier<int?> _currentPage = ValueNotifier(null);

  ValueNotifier<int?> get currentPage => _currentPage;

  final ValueNotifier<int?> _initialPage = ValueNotifier(null);

  ValueNotifier<int?> get initialPage => _initialPage;

  final ValueNotifier<List<Memory>?> _imageFiles = ValueNotifier(null);

  ValueNotifier<List<Memory>?> get imageFiles => _imageFiles;

  Directory? directory;

  ImageViewerViewModel({required this.memoryRepository});

  @override
  void onViewReady({ImageViewerArgument? argument}) {
    super.onViewReady();
    _init(argument: argument);
  }

  Future<void> _init({ImageViewerArgument? argument}) async {
    _initialPage.value = argument!.initialPage;
    _currentPage.value = argument.initialPage;
    _imageFiles.value = await memoryRepository.getImages();
  }

  void onPageChanged(int index) {
    _currentPage.value = index;
  }

  Future<void> onMoreButtonPressed() async {
    downloadImage();
  }

  Future<void> downloadImage() async {
    try {
      if (imageFiles.value == null || _currentPage.value == null) {
        throw Exception("Image files or current page is null");
      }

      String sourceFilePath = imageFiles.value![_currentPage.value!].imagePath;

      final sourceFile = File(sourceFilePath);
      if (!await sourceFile.exists()) {
        throw Exception("Source file does not exist: $sourceFilePath");
      }

      final hasPermission =
          await StoragePermissionHandler.requestStoragePermission();
      if (!hasPermission) {
        throw Exception(
            "Storage permission required. Please grant permission in Settings and try again.");
      }

      final imageBytes = await sourceFile.readAsBytes();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filename = 'MT-v15_memory_${_currentPage.value}_$timestamp.jpg';

      await FileDownloader.writeFile(filename, imageBytes);
    } catch (e) {
      rethrow;
    }
  }

  void onNavigateBack() {
    navigateBack();
  }
}
