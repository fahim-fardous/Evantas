import 'dart:io';

import 'package:domain/repository/memory_repository.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/image_viewer/route/image_viewer_argument.dart';
import 'package:evntas/presentation/feature/image_viewer/route/image_viewer_route.dart';
import 'package:evntas/presentation/feature/memory/route/memory_argument.dart';
import 'package:evntas/presentation/localization/ui_text.dart';
import 'package:flutter/material.dart';

class MemoryViewModel extends BaseViewModel<MemoryArgument> {
  final MemoryRepository memoryRepository;
  final ValueNotifier<List<String>?> _imageFiles = ValueNotifier([]);

  ValueNotifier<List<String>?> get imageFiles => _imageFiles;

  MemoryViewModel({required this.memoryRepository});

  @override
  void onViewReady({MemoryArgument? argument}) {
    super.onViewReady();
    _init();
  }

  Future<void> _init() async {
    final images = await getImages();
    _imageFiles.value = images;
  }

  Future<void> addImage(File image) async {
    final images = await getImages();

    if (images.contains(image.path)) {
      showToast(uiText: FixedUiText(text: "Image already exists"));
      return;
    }
    if (_imageFiles.value == null) {
      return;
    }
    await loadData(memoryRepository.saveImage(image.path));
    _imageFiles.value = _imageFiles.value!..add(image.path);
  }

  Future<List<String>> getImages() async {
    final images = await loadData(memoryRepository.getImages());
    return images.map((e) => e.imagePath).toList();
  }

  void onImagePressed(int index) {
    navigateToScreen(
      destination: ImageViewerRoute(
        arguments: ImageViewerArgument(initialPage: index),
      ),
    );
  }
}
