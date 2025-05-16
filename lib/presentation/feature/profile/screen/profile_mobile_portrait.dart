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
      body: valueListenableBuilder(
        listenable: widget.viewModel.message,
        builder: (context, value) {
          return InkWell(
            child: Text('Profile: $value'),
            onTap: () => widget.viewModel.onClick(),
          );
        },
      ),
    );
  }
}
