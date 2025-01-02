import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_adaptive_ui.dart';
import 'package:hello_flutter/presentation/base/base_ui_state.dart';
import 'package:hello_flutter/presentation/common/extension/context_ext.dart';
import 'package:hello_flutter/presentation/common/widget/asset_image_view.dart';
import 'package:hello_flutter/presentation/feature/splash/splash_view_model.dart';
import 'package:hello_flutter/presentation/theme/color/app_colors.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';

class SplashMobilePortrait extends StatefulWidget {
  final SplashViewModel viewModel;

  const SplashMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => SplashMobilePortraitState();
}

class SplashMobilePortraitState extends BaseUiState<SplashMobilePortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: valueListenableBuilder(
        listenable: widget.viewModel.appInfo,
        builder: (context, value) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AssetImageView(
                  fileName: 'app_logo.png',
                  width: Dimens.dimen_120,
                  height: Dimens.dimen_120,
                ),
                Text(
                  context.localizations.app_name,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: Dimens.dimen_24,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
