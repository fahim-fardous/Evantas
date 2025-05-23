import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/memory/memory_view_model.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/util/constants.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:image_picker/image_picker.dart';

class MemoryMobilePortrait extends StatefulWidget {
  final MemoryViewModel viewModel;

  const MemoryMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => MemoryMobilePortraitState();
}

class MemoryMobilePortraitState extends BaseUiState<MemoryMobilePortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memory", style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        )),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildFloatingActionButton(context),
      body: SafeArea(
        child: valueListenableBuilder(
          listenable: widget.viewModel.uploadedImages,
          builder: (context, value) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.dimen_16,
              vertical: Dimens.dimen_16,
            ),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: value.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: Dimens.dimen_4,
                      mainAxisSpacing: Dimens.dimen_4,
                      childAspectRatio: 1, // square cells
                    ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => widget.viewModel.onTapPhoto(index),
                        child: GestureDetector(
                          onLongPress: () => _showDeleteDialog(value[index]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              value.isNotEmpty
                                  ? value[index]
                                  : Constants.emptyPlaceholderUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Photo"),
        content: const Text("Do you want to delete this photo?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.viewModel.deletePhoto(imageUrl);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }


  Widget _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimens.dimen_16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: "camera",
            backgroundColor: AppColors.of(context).mainColor,
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            onPressed: () => widget.viewModel.uploadPhoto(ImageSource.camera),
          ),
          SizedBox(
            width: Dimens.dimen_4,
          ),
          FloatingActionButton(
            heroTag: "gallery",
            backgroundColor: AppColors.of(context).secondary,
            child: const Icon(
              Icons.image,
              color: Colors.white,
            ),
            onPressed: () => widget.viewModel.uploadPhoto(ImageSource.gallery),
          ),
        ],
      ),
    );
  }

}
