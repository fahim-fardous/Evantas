import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/memory/memory_view_model.dart';
import 'package:hello_flutter/presentation/theme/color/app_colors.dart';
import 'package:hello_flutter/presentation/util/constants.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';
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
        title: const Text("Memory"),
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
                      onTap: () => widget.viewModel.onTapPhoto(
                        index,
                      ),
                      child: Image.network(
                        value.isNotEmpty
                            ? value[index]
                            : Constants.emptyPlaceholderUrl,
                        fit: BoxFit.cover,
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
