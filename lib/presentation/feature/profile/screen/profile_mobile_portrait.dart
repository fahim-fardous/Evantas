import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/model/user_response_data.dart';
import 'package:evntas/presentation/common/extension/context_ext.dart';
import 'package:evntas/presentation/common/widget/common_drop_down_field.dart';
import 'package:evntas/presentation/feature/profile/widgets/info_card.dart';
import 'package:evntas/presentation/feature/profile/widgets/profile_menu_tile.dart';
import 'package:evntas/presentation/feature/profile/widgets/TextWithIcon.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/feature/profile/profile_view_model.dart';

class ProfileMobilePortrait extends StatefulWidget {
  final ProfileViewModel viewModel;

  const ProfileMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => ProfileMobilePortraitState();
}

class ProfileMobilePortraitState extends BaseUiState<ProfileMobilePortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Profile",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.dimen_16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            valueListenableBuilder(
              listenable: widget.viewModel.userData,
              builder: (context, value) => (value?.photoUrl != null)
                  ? _buildPhotoView(context, value)
                  : Container(),
            ),
            SizedBox(height: Dimens.dimen_16),
            valueListenableBuilder(
              listenable: widget.viewModel.userData,
              builder: (context, value) => Text(
                value?.name ?? '',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(height: Dimens.dimen_4),
            valueListenableBuilder(
              listenable: widget.viewModel.userData,
              builder: (context, value) => Text(
                value?.email ?? '',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            SizedBox(height: Dimens.dimen_16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InfoCard(value: 6, title: 'Points'),
                SizedBox(width: Dimens.dimen_10),
                valueListenableBuilder(
                  listenable: widget.viewModel.issueCount,
                  builder: (context, value) =>
                      InfoCard(value: value, title: 'Issues'),
                ),
              ],
            ),
            SizedBox(height: Dimens.dimen_36),
            ProfileMenuTile(
              icon: Icons.account_circle_outlined,
              text: "Edit Profile",
              color: Theme.of(context).colorScheme.primary,
              onTap: () => widget.viewModel.onEditProfilePressed(),
            ),
            SizedBox(height: Dimens.dimen_16),
            ProfileMenuTile(
              icon: Icons.error_outline,
              text: 'Issues',
              color: Theme.of(context).colorScheme.primary,
              onTap: () => widget.viewModel.onIssuesPressed(),
            ),
            SizedBox(height: Dimens.dimen_16),
            GestureDetector(
              onTap: () => widget.viewModel.onPointsPressed(),
              child: ProfileMenuTile(
                icon: Icons.stars,
                text: 'Points',
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: Dimens.dimen_16),
            ProfileMenuTile(
              icon: Icons.lock_open,
              text: 'Logout',
              color: Theme.of(context).colorScheme.error,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CommonDropDownField(
                    title: "Logout",
                    description: "Are you sure you want to logout?",
                    positiveButtonLabel: "Sign out",
                    negativeButtonLabel: "Cancel",
                    onPositiveButtonPressed: () => widget.viewModel.signOut(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoView(BuildContext context, UserResponseData? value) {
    return Stack(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: value?.photoUrl ?? '',
            width: Dimens.dimen_100,
            height: Dimens.dimen_100,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            padding: EdgeInsets.all(Dimens.dimen_5),
            child: GestureDetector(
              onTap: () => _showPhotoSelectionBottomSheet(context),
              child: Icon(
                Icons.camera_alt, // pen icon
                size: Dimens.dimen_16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _showPhotoSelectionBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.dimen_20,
          vertical: Dimens.dimen_20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            valueListenableBuilder(
              listenable: widget.viewModel.userData,
              builder: (context, user) => TextWithIcon(
                icon: Icons.person_2_rounded,
                text: context.localizations.see_profile_picture,
                onTap: () {
                  Navigator.pop(context);
                  widget.viewModel.onSeeProfilePicture(
                    user?.photoUrl ?? '',
                  );
                },
              ),
            ),
            SizedBox(height: Dimens.dimen_20),
            TextWithIcon(
              icon: Icons.photo_album,
              text: context.localizations.select_profile_picture,
              onTap: () {
                Navigator.pop(context);
                widget.viewModel.selectProfilePicture();
              },
            )
          ],
        ),
      ),
    );
  }
}
