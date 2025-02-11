import 'dart:io';
import 'dart:math';

import 'package:domain/util/logger.dart';
import 'package:evntas/presentation/common/widget/asset_image_view.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/memory/memory_view_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class MemoryMobilePortrait extends StatefulWidget {
  final MemoryViewModel viewModel;

  const MemoryMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => MemoryMobilePortraitState();
}

class MemoryMobilePortraitState extends BaseUiState<MemoryMobilePortrait> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File cachedFile = File(pickedFile.path);

      final directory = await getApplicationDocumentsDirectory();
      final newPath = '${directory.path}/${pickedFile.name}';

      File savedFile = await cachedFile.copy(newPath);

      widget.viewModel.addImage(savedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _pickImage(ImageSource.gallery);
        },
        backgroundColor: AppColors.of(context).primary,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Dimens.dimen_16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: widget.viewModel.imageFiles,
                builder: (context, images, _) {
                  if(images == null) {
                    return SizedBox.shrink();
                  }
                  return (images.isNotEmpty)
                      ? Expanded(
                          child: MasonryGridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: Dimens.dimen_10,
                            crossAxisSpacing: Dimens.dimen_10,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return Image(
                                image: FileImage(
                                  File(images[index]),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: AssetImageView(
                            fileName: 'no_photo_found.svg',
                            height: Dimens.dimen_100,
                            width: Dimens.dimen_100,
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
