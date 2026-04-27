import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/model/user_response_data.dart';
import 'package:evntas/presentation/common/extension/context_ext.dart';
import 'package:evntas/presentation/common/widget/common_drop_down_field.dart';
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
  static const Color _mintBackground = Color(0xFFF3FAF6);
  static const Color _mintCardBorder = Color(0xFFD3E9DD);
  static const Color _mintPrimaryDark = Color(0xFF2F6B4F);
  static const Color _mintPrimary = Color(0xFF4FA071);
  static const Color _mintPrimarySoft = Color(0xFF86C8A3);
  static const Color _logoutSoft = Color(0xFFE8A19A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _mintBackground,
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
            Text(
              "Profile",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: _mintPrimaryDark,
                    fontWeight: FontWeight.w700,
                    fontSize: Dimens.dimen_42 / Dimens.dimen_2,
                    height: Dimens.dimen_12 / Dimens.dimen_10,
                  ),
            ),
            SizedBox(height: Dimens.dimen_20),
            _buildProfileCard(context),
            SizedBox(height: Dimens.dimen_24),
            _buildActionTile(
              context: context,
              icon: Icons.manage_accounts_outlined,
              title: "Edit Profile",
              subtitle: "Update your info & photo",
              color: _mintPrimaryDark,
              subtitleColor: _mintPrimary,
              onTap: widget.viewModel.onEditProfilePressed,
            ),
            SizedBox(height: Dimens.dimen_14),
            valueListenableBuilder(
              listenable: widget.viewModel.issueCount,
              builder: (context, issueCount) => _buildActionTile(
                context: context,
                icon: Icons.error_outline,
                title: "Issues",
                subtitle: "$issueCount open issues",
                color: _mintPrimaryDark,
                subtitleColor: _mintPrimary,
                onTap: widget.viewModel.onIssuesPressed,
              ),
            ),
            SizedBox(height: Dimens.dimen_14),
            _buildActionTile(
              context: context,
              icon: Icons.stars_outlined,
              title: "Points",
              subtitle: "6 points earned",
              color: _mintPrimaryDark,
              subtitleColor: _mintPrimary,
              onTap: widget.viewModel.onPointsPressed,
            ),
            SizedBox(height: Dimens.dimen_14),
            _buildActionTile(
              context: context,
              icon: Icons.logout,
              title: "Logout",
              subtitle: "Sign out of your account",
              color: Theme.of(context).colorScheme.error,
              subtitleColor: _logoutSoft,
              isLogout: true,
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.dimen_18,
        vertical: Dimens.dimen_20,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(Dimens.dimen_85 / Dimens.dimen_100),
        borderRadius: BorderRadius.circular(Dimens.dimen_20),
        border: Border.all(
          color: _mintCardBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: _mintPrimary.withOpacity(Dimens.dimen_12 / Dimens.dimen_100),
            blurRadius: Dimens.dimen_16,
            offset: Offset(Dimens.dimen_0, Dimens.dimen_4),
          ),
        ],
      ),
      child: Column(
        children: [
          valueListenableBuilder(
            listenable: widget.viewModel.userData,
            builder: (context, value) => _buildPhotoView(context, value),
          ),
          SizedBox(height: Dimens.dimen_14),
          valueListenableBuilder(
            listenable: widget.viewModel.userData,
            builder: (context, value) => Text(
              value?.name ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: _mintPrimaryDark,
                    fontWeight: FontWeight.w800,
                    fontSize: Dimens.dimen_19,
                    height: Dimens.dimen_12 / Dimens.dimen_10,
                  ),
            ),
          ),
          SizedBox(height: Dimens.dimen_4),
          valueListenableBuilder(
            listenable: widget.viewModel.userData,
            builder: (context, value) => Text(
              value?.email ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: _mintPrimary,
                    fontSize: Dimens.dimen_14,
                    fontWeight: FontWeight.w700,
                    height: Dimens.dimen_12 / Dimens.dimen_10,
                  ),
            ),
          ),
          SizedBox(height: Dimens.dimen_18),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context: context,
                  value: 6,
                  title: 'Points',
                ),
              ),
              Container(
                width: Dimens.dimen_1,
                height: Dimens.dimen_44,
                color: _mintPrimarySoft.withOpacity(Dimens.dimen_6 / Dimens.dimen_10),
              ),
              Expanded(
                child: valueListenableBuilder(
                  listenable: widget.viewModel.issueCount,
                  builder: (context, value) => _buildStatItem(
                    context: context,
                    value: value,
                    title: 'Issues',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required BuildContext context,
    required int value,
    required String title,
  }) {
    return Column(
      children: [
        Text(
          '$value',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: _mintPrimary,
                fontWeight: FontWeight.w800,
                fontSize: Dimens.dimen_19,
                height: Dimens.dimen_11 / Dimens.dimen_10,
              ),
        ),
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: _mintPrimarySoft,
                fontWeight: FontWeight.w800,
                fontSize: Dimens.dimen_12,
                letterSpacing: Dimens.dimen_8 / Dimens.dimen_10,
              ),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color subtitleColor,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimens.dimen_16),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Dimens.dimen_14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(Dimens.dimen_82 / Dimens.dimen_100),
          borderRadius: BorderRadius.circular(Dimens.dimen_16),
          border: Border.all(
            color: isLogout
                ? _logoutSoft.withOpacity(Dimens.dimen_55 / Dimens.dimen_100)
                : _mintCardBorder,
          ),
          boxShadow: [
            BoxShadow(
              color: _mintPrimary.withOpacity(Dimens.dimen_8 / Dimens.dimen_100),
              blurRadius: Dimens.dimen_12,
              offset: Offset(Dimens.dimen_0, Dimens.dimen_3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Dimens.dimen_10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isLogout
                    ? _logoutSoft.withOpacity(Dimens.dimen_18 / Dimens.dimen_100)
                    : _mintPrimarySoft.withOpacity(Dimens.dimen_22 / Dimens.dimen_100),
              ),
              child: Icon(
                icon,
                color: color,
                size: Dimens.dimen_22,
              ),
            ),
            SizedBox(width: Dimens.dimen_14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w800,
                          fontSize: Dimens.dimen_16,
                          height: Dimens.dimen_12 / Dimens.dimen_10,
                        ),
                  ),
                  SizedBox(height: Dimens.dimen_2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: subtitleColor,
                          fontSize: Dimens.dimen_13,
                          fontWeight: FontWeight.w600,
                          height: Dimens.dimen_12 / Dimens.dimen_10,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: Dimens.dimen_16,
              color: isLogout ? _logoutSoft : _mintPrimarySoft,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
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
  }

  Widget _buildPhotoView(BuildContext context, UserResponseData? value) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(Dimens.dimen_3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _mintPrimary,
              width: Dimens.dimen_3,
            ),
          ),
          child: ClipOval(
            child: (value?.photoUrl?.isNotEmpty ?? false)
                ? CachedNetworkImage(
                    imageUrl: value?.photoUrl ?? '',
                    width: Dimens.dimen_100,
                    height: Dimens.dimen_100,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: Dimens.dimen_100,
                    height: Dimens.dimen_100,
                    color: _mintPrimarySoft.withOpacity(Dimens.dimen_3 / Dimens.dimen_10),
                    child: Icon(
                      Icons.person,
                      size: Dimens.dimen_56,
                      color: _mintPrimary,
                    ),
                  ),
          ),
        ),
        Positioned(
          bottom: -Dimens.dimen_2,
          right: -Dimens.dimen_2,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _mintPrimary,
              border: Border.all(
                color: Colors.white,
                width: Dimens.dimen_2,
              ),
            ),
            padding: EdgeInsets.all(Dimens.dimen_6),
            child: GestureDetector(
              onTap: () => _showPhotoSelectionBottomSheet(context),
              child: Icon(
                Icons.camera_alt,
                size: Dimens.dimen_16,
                color: Colors.white,
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
