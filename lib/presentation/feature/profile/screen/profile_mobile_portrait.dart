import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/model/user_response_data.dart';
import 'package:evntas/presentation/common/extension/context_ext.dart';
import 'package:evntas/presentation/feature/profile/widgets/BoxWithTextAndArrow.dart';
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
      title: Text("Profile"),
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: Dimens.dimen_4),
            valueListenableBuilder(
              listenable: widget.viewModel.userData,
              builder: (context, value) => Text(
                value?.email ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: Dimens.dimen_64),
            BoxWithTextAndArrow(
              text: "Edit Profile",
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: Dimens.dimen_16),
            BoxWithTextAndArrow(
              text: 'Issues',
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: Dimens.dimen_16),
            BoxWithTextAndArrow(
              text: 'Points',
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: Dimens.dimen_16),
            BoxWithTextAndArrow(
              text: 'Logout',
              color: Theme.of(context).colorScheme.error,
              onTap: () => widget.viewModel.signOut(),
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
                color: Theme.of(context).colorScheme.onBackground,
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
            TextWithIcon(
              icon: Icons.person_2_rounded,
              text: context.localizations.see_profile_picture,
              onTap: () {},
            ),
            SizedBox(height: Dimens.dimen_20),
            TextWithIcon(
              icon: Icons.photo_album,
              text: context.localizations.select_profile_picture,
              onTap: (){},
            )
          ],
        ),
      ),
    );
  }
}
