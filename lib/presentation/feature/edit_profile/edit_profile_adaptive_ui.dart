import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_adaptive_ui.dart';
import 'package:evntas/presentation/feature/edit_profile/binding/edit_profile_binding.dart';
import 'package:evntas/presentation/feature/edit_profile/route/edit_profile_argument.dart';
import 'package:evntas/presentation/feature/edit_profile/edit_profile_view_model.dart';
import 'package:evntas/presentation/feature/edit_profile/route/edit_profile_route.dart';
import 'package:evntas/presentation/feature/edit_profile/screen/edit_profile_mobile_portrait.dart';
import 'package:evntas/presentation/feature/edit_profile/screen/edit_profile_mobile_landscape.dart';

class EditProfileAdaptiveUi extends BaseAdaptiveUi<EditProfileArgument, EditProfileRoute> {
  const EditProfileAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => EditProfileAdaptiveUiState();
}

class EditProfileAdaptiveUiState extends BaseAdaptiveUiState<EditProfileArgument, EditProfileRoute, EditProfileAdaptiveUi, EditProfileViewModel, EditProfileBinding> {
  @override
  EditProfileBinding binding = EditProfileBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return EditProfileMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return EditProfileMobileLandscape(viewModel: viewModel);
  }
}
