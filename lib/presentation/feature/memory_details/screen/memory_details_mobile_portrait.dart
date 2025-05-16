import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/memory_details/memory_details_view_model.dart';

class MemoryDetailsMobilePortrait extends StatefulWidget {
  final int initialIndex;
  final MemoryDetailsViewModel viewModel;

  const MemoryDetailsMobilePortrait({
    required this.initialIndex,
    required this.viewModel,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => MemoryDetailsMobilePortraitState();
}

class MemoryDetailsMobilePortraitState
    extends BaseUiState<MemoryDetailsMobilePortrait> {
  PageController? _pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: valueListenableBuilder(
          listenable: widget.viewModel.uploadedImages,
          builder: (context, value) => valueListenableBuilder(
            listenable: widget.viewModel.currentIndex,
            builder: (context, index) => (value.isNotEmpty && index != null)
                ? Text(value[index].split('/').last)
                : Container(),
          ),
        ),
        actions: [
          valueListenableBuilder(
              listenable: widget.viewModel.uploadedImages,
              builder: (context, value) => valueListenableBuilder(
                    listenable: widget.viewModel.currentIndex,
                    builder: (context, index) => (index != null)
                        ? IconButton(
                            onPressed: () => {
                                  widget.viewModel
                                      .downloadPhoto(
                                          value[index])
                                },
                            icon: const Icon(Icons.download))
                        : Container(),
                  ))
        ],
      ),
      body: valueListenableBuilder(
        listenable: widget.viewModel.uploadedImages,
        builder: (context, value) {
          if (value.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          _pageController ??= PageController(initialPage: widget.initialIndex);

          return PageView.builder(
            controller: _pageController,
            itemCount: value.length,
            itemBuilder: (context, index) => Center(
              child: Image.network(
                value[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
