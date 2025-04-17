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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          valueListenableBuilder(
            listenable: widget.viewModel.user,
            builder: (context, user) => ClipOval(
              child: Image.network(
                user?.photoUrl ?? '',
                width: Dimens.dimen_100,
                height: Dimens.dimen_100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.person,
                  size: Dimens.dimen_100,
                ),
              ),
            ),
          ),
          SizedBox(height: Dimens.dimen_20),
          valueListenableBuilder(
            listenable: widget.viewModel.user,
            builder: (context, user) => Text(
              user?.displayName ?? '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(height: Dimens.dimen_20),
          valueListenableBuilder(
            listenable: widget.viewModel.user,
            builder: (context, user) => Text(
              user?.email ?? '',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
