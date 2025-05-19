import 'package:cached_network_image/cached_network_image.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/profile_picture/profile_picture_view_model.dart';

class ProfilePictureMobilePortrait extends StatefulWidget {
  final ProfilePictureViewModel viewModel;
  final String profilePhotoUrl;

  const ProfilePictureMobilePortrait({
    required this.viewModel,
    super.key,
    required this.profilePhotoUrl,
  });

  @override
  State<StatefulWidget> createState() => ProfilePictureMobilePortraitState();
}

class ProfilePictureMobilePortraitState
    extends BaseUiState<ProfilePictureMobilePortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              width: double.infinity,
              imageUrl: widget.profilePhotoUrl,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Profile Picture',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      leading: IconButton(
        onPressed: () => widget.viewModel.onBackPress(),
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
