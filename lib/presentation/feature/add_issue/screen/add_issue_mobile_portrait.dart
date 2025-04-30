import 'package:evntas/presentation/common/widget/outlined_text_field.dart';
import 'package:evntas/presentation/common/widget/primary_button.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/add_issue/add_issue_view_model.dart';

class AddIssueMobilePortrait extends StatefulWidget {
  final AddIssueViewModel viewModel;

  const AddIssueMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => AddIssueMobilePortraitState();
}

class AddIssueMobilePortraitState extends BaseUiState<AddIssueMobilePortrait> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Add Issue"),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.dimen_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedTextField(
              controller: titleController,
              labelText: "Title",
              hintText: "Enter title"),
          SizedBox(height: Dimens.dimen_16),
          OutlinedTextField(
              controller: descriptionController,
              labelText: "Description",
              hintText: "Enter description",
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: Dimens.dimen_16),
          PrimaryButton(
            onPressed: () => widget.viewModel.onSavePressed(
              titleController.text,
              descriptionController.text,
            ),
            label: 'Save',
            minWidth: double.infinity,
          ),
        ],
      ),
    );
  }
}
