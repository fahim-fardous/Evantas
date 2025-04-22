import 'package:evntas/presentation/common/extension/context_ext.dart';
import 'package:evntas/presentation/common/widget/outlined_text_field.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/edit_profile/edit_profile_view_model.dart';

class EditProfileMobilePortrait extends StatefulWidget {
  final EditProfileViewModel viewModel;

  const EditProfileMobilePortrait({required this.viewModel, super.key});

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
        title: Text(context.localizations.edit_profile),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => widget.viewModel.onBackPressed(),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        OutlinedTextField(
            controller: _nameController,
            labelText: "Name",
            hintText: "Update your name"),
        SizedBox(height: Dimens.dimen_16),
        OutlinedTextField(
            controller: _emailController,
            labelText: "Email",
            hintText: "Update your email")
      ],
    );
  }
}
