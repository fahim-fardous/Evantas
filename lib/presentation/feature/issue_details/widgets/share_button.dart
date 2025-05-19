import 'package:evntas/presentation/common/widget/asset_image_view.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.dimen_16,
        vertical: Dimens.dimen_8,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.1),
        borderRadius: BorderRadius.circular(Dimens.dimen_8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AssetImageView(
            fileName: 'share_icon.png',
            width: Dimens.dimen_18,
            height: Dimens.dimen_18,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: Dimens.dimen_8),
          Text(
            "Share",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: Dimens.dimen_14,
                ),
          ),
        ],
      ),
    );
  }
}
