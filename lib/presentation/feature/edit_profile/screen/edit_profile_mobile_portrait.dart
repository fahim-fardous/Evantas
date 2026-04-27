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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Dimens.dimen_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileHeader(context),
            SizedBox(height: Dimens.dimen_20),
            _buildEditFormCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return valueListenableBuilder(
      listenable: widget.viewModel.userData,
      builder: (context, user) => Container(
        padding: EdgeInsets.all(Dimens.dimen_16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(
            Dimens.dimen_4 / Dimens.dimen_10,
          ),
          borderRadius: BorderRadius.circular(Dimens.dimen_16),
          border: Border.all(
            color: colorScheme.outline.withOpacity(
              Dimens.dimen_2 / Dimens.dimen_10,
            ),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: Dimens.dimen_24,
              backgroundColor: colorScheme.primary.withOpacity(
                Dimens.dimen_15 / Dimens.dimen_100,
              ),
              child: Icon(
                Icons.person_outline,
                color: colorScheme.primary,
              ),
            ),
            SizedBox(width: Dimens.dimen_12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? '-',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(height: Dimens.dimen_4),
                  Text(
                    user?.email ?? '-',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditFormCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Dimens.dimen_16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(Dimens.dimen_16),
        border: Border.all(
          color: colorScheme.outline.withOpacity(
            Dimens.dimen_2 / Dimens.dimen_10,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(
              Dimens.dimen_8 / Dimens.dimen_100,
            ),
            blurRadius: Dimens.dimen_12,
            offset: Offset(Dimens.dimen_0, Dimens.dimen_4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Profile details",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(height: Dimens.dimen_8),
          Text(
            "Leave a field empty to keep existing value.",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          SizedBox(height: Dimens.dimen_16),
          OutlinedTextField(
            controller: _nameController,
            labelText: "Name",
            hintText: "Update your name",
          ),
          SizedBox(height: Dimens.dimen_14),
          OutlinedTextField(
            controller: _emailController,
            labelText: "Email",
            hintText: "Update your email",
          ),
          SizedBox(height: Dimens.dimen_20),
          SizedBox(
            height: Dimens.dimen_48,
            child: ElevatedButton.icon(
              onPressed: () => widget.viewModel.onSavePressed(
                widget.userId,
                _nameController.text.trim(),
                _emailController.text.trim(),
              ),
              icon: Icon(Icons.check_circle_outline),
              label: Text(context.localizations.save),
            ),
          ),
        ],
      ),
    );
  }
}
