import 'package:evntas/presentation/common/extension/context_ext.dart';
import 'package:evntas/presentation/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/memory/widget/memory_cards_section.dart';
import 'package:evntas/presentation/feature/memory/widget/memory_header.dart';
import 'package:evntas/presentation/feature/memory/memory_view_model.dart';
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: valueListenableBuilder(
          listenable: widget.viewModel.uploadedImages,
          builder: (context, value) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.dimen_20,
              vertical: Dimens.dimen_16,
            ),
            child: Column(
              children: [
                MemoryHeader(
                  onAddMemoryTap: _showUploadSourceSheet,
                ),
                SizedBox(height: Dimens.dimen_18),
                Expanded(
                  child: ListView(
                    children: [
                      MemoryCardsSection(
                        images: value,
                        onTapImage: widget.viewModel.onTapPhoto,
                        onLongPressImage: _showDeleteDialog,
                        onAddMemoryTap: _showUploadSourceSheet,
                      ),
                    ],
                  ),
                ),
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

  void _showUploadSourceSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.dimen_16,
              vertical: Dimens.dimen_8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: const Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.viewModel.uploadPhoto(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image_outlined),
                  title: const Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.viewModel.uploadPhoto(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
