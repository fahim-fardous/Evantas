import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_ui_state.dart';
import 'package:hello_flutter/presentation/common/widget/asset_image_view.dart';
import 'package:hello_flutter/presentation/feature/auth/sign_up/sign_up_view_model.dart';
import 'package:hello_flutter/presentation/theme/color/app_colors.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';

class SignUpMobilePortrait extends StatefulWidget {
  final SignUpViewModel viewModel;

  const SignUpMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => SignUpMobilePortraitState();
}

class SignUpMobilePortraitState extends BaseUiState<SignUpMobilePortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Dimens.dimen_128,
              height: Dimens.dimen_128,
              padding: EdgeInsets.all(Dimens.dimen_16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.of(context).mainColor.withOpacity(.25),
                borderRadius: BorderRadius.circular(Dimens.dimen_16),
              ),
              child: const AssetImageView(
                fileName: 'claps.svg',
              ),
            )
          ],
        ));
  }
}
