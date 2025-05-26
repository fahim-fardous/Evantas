import 'package:evntas/presentation/common/extension/context_ext.dart';
import 'package:evntas/presentation/common/widget/outlined_text_field.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/edit_profile/edit_profile_view_model.dart';

class EditProfileMobilePortrait extends StatefulWidget {
  final EditProfileViewModel viewModel;
  final String userId;

  const EditProfileMobilePortrait({
    required this.viewModel,
    required this.userId,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => EditProfileMobilePortraitState();
}

class EditProfileMobilePortraitState
    extends BaseUiState<EditProfileMobilePortrait> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localizations.edit_profile,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.viewModel.onBackPressed();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.dimen_16),
      child: Column(
        children: [
          OutlinedTextField(
            controller: _nameController,
            labelText: "Name",
            hintText: "Update your name",
          ),
          SizedBox(height: Dimens.dimen_16),
          OutlinedTextField(
            controller: _emailController,
            labelText: "Email",
            hintText: "Update your email",
          ),
          SizedBox(height: Dimens.dimen_16),
          ElevatedButton(
            onPressed: () => widget.viewModel.onSavePressed(
              widget.userId,
              _nameController.text,
              _emailController.text,
            ),
            child: Text(context.localizations.save),
          ),
        ],
      ),
    );
  }
}
