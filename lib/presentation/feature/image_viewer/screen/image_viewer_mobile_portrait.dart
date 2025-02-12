import 'dart:io';

import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/image_viewer/image_viewer_view_model.dart';

class ImageViewerMobilePortrait extends StatefulWidget {
  final ImageViewerViewModel viewModel;
  final int initialPage;

  const ImageViewerMobilePortrait({
    super.key,
    required this.initialPage,
    required this.viewModel,
  });

  @override
  State<StatefulWidget> createState() => ImageViewerMobilePortraitState();
}

class ImageViewerMobilePortraitState
    extends BaseUiState<ImageViewerMobilePortrait> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => widget.viewModel.onNavigateBack(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => widget.viewModel.onMoreButtonPressed(),
          ),
        ],
      ),
      body: valueListenableBuilder(
          listenable: widget.viewModel.imageFiles,
          builder: (context, images) {
            if (images == null) {
              return Container();
            }
            return PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              onPageChanged: (index) => widget.viewModel.onPageChanged(index),
              itemBuilder: (context, index) => Center(
                child: Image.file(
                  File(images[index].imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
