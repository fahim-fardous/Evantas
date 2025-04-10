import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_ui_state.dart';
import 'package:hello_flutter/presentation/feature/memory/memory_view_model.dart';
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
        title: Text("Memory"),
        leading: IconButton(onPressed: () => widget.viewModel.onBackButtonPressed(), icon: Icon(Icons.arrow_back)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildFloatingActionButton(context),
      body: SafeArea(
        child: valueListenableBuilder(
          listenable: widget.viewModel.uploadedImages,
          builder: (context, value) => Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.dimen_16, vertical: Dimens.dimen_16),
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
                    itemBuilder: (context, index) => Image.network(
                      value.isNotEmpty
                          ? value[index]
                          : 'https://ixcgefrdqdlqmpveunyu.supabase.co/storage/v1/object/public/photos/empty_placeholder.jpg',
                      fit: BoxFit.cover,
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
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => widget.viewModel.uploadPhoto(ImageSource.camera),
    );
  }
}
