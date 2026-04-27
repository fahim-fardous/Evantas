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
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Add Issue",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          Dimens.dimen_16,
          Dimens.dimen_16,
          Dimens.dimen_16,
          Dimens.dimen_24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIntroCard(context),
            SizedBox(height: Dimens.dimen_16),
            _buildFormCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimens.dimen_16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.dimen_16),
        color: Theme.of(context).colorScheme.background,
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(Dimens.dimen_1 / Dimens.dimen_8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Dimens.dimen_40,
            height: Dimens.dimen_40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(Dimens.dimen_1 / Dimens.dimen_8),
            ),
            child: Icon(
              Icons.edit_note_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(width: Dimens.dimen_12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Describe your issue clearly",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                SizedBox(height: Dimens.dimen_6),
                Text(
                  "A descriptive title and proper details help others understand and respond faster.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimens.dimen_16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(Dimens.dimen_16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(Dimens.dimen_1 / Dimens.dimen_12),
            blurRadius: Dimens.dimen_16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Issue Details",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          SizedBox(height: Dimens.dimen_12),
          OutlinedTextField(
            controller: titleController,
            labelText: "Title",
            hintText: "Enter title",
          ),
          SizedBox(height: Dimens.dimen_16),
          OutlinedTextField(
            controller: descriptionController,
            labelText: "Description",
            hintText: "Enter description",
            maxLines: Dimens.dimen_6.toInt(),
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: Dimens.dimen_20),
          PrimaryButton(
            onPressed: () => widget.viewModel.onSavePressed(
              titleController.text.trim(),
              descriptionController.text.trim(),
            ),
            label: "Save Issue",
            leadingIcon: Icons.check_circle_outline,
            minWidth: double.infinity,
          ),
        ],
      ),
    );
  }
}
