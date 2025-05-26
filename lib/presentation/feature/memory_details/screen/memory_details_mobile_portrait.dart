import 'package:evntas/presentation/common/extension/context_ext.dart';
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
                            onPressed: () => _showDeleteDialog(value[index]),
                            icon: const Icon(
                              Icons.delete,
                            ),
                          )
                        : Container(),
                  )),
          valueListenableBuilder(
              listenable: widget.viewModel.uploadedImages,
              builder: (context, value) => valueListenableBuilder(
                listenable: widget.viewModel.currentIndex,
                builder: (context, index) => (index != null)
                    ? IconButton(
                  onPressed: () => {
                    widget.viewModel.downloadPhoto(
                      value[index],
                    ),
                  },
                  icon: const Icon(
                    Icons.download,
                  ),
                )
                    : Container(),
              ))
        ],
      ),
      body: valueListenableBuilder(
        listenable: widget.viewModel.uploadedImages,
        builder: (context, value) {
          if (value.isEmpty) {
            return const SizedBox.shrink();
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

  void _showDeleteDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.localizations.delete_photo),
        content: Text(context.localizations.delete_photo_confirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.localizations.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.viewModel.deletePhoto(imageUrl);
            },
            child: Text(context.localizations.ok),
          ),
        ],
      ),
    );
  }

}
