import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_adaptive_ui.dart';
import 'package:evntas/presentation/feature/profile_picture/binding/profile_picture_binding.dart';
import 'package:evntas/presentation/feature/profile_picture/route/profile_picture_argument.dart';
import 'package:evntas/presentation/feature/profile_picture/profile_picture_view_model.dart';
import 'package:evntas/presentation/feature/profile_picture/route/profile_picture_route.dart';
import 'package:evntas/presentation/feature/profile_picture/screen/profile_picture_mobile_portrait.dart';
import 'package:evntas/presentation/feature/profile_picture/screen/profile_picture_mobile_landscape.dart';

class ProfilePictureAdaptiveUi
    extends BaseAdaptiveUi<ProfilePictureArgument, ProfilePictureRoute> {
  const ProfilePictureAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => ProfilePictureAdaptiveUiState();
}

class ProfilePictureAdaptiveUiState extends BaseAdaptiveUiState<
    ProfilePictureArgument,
    ProfilePictureRoute,
    ProfilePictureAdaptiveUi,
    ProfilePictureViewModel,
    ProfilePictureBinding> {
  @override
  ProfilePictureBinding binding = ProfilePictureBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return ProfilePictureMobilePortrait(
      viewModel: viewModel,
      profilePhotoUrl: widget.argument?.profilePhotoUrl ?? '',
    );
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return ProfilePictureMobileLandscape(
      viewModel: viewModel,
      profilePhotoUrl: widget.argument?.profilePhotoUrl ?? '',
    );
  }
}
