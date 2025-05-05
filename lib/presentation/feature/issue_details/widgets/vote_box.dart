import 'package:evntas/presentation/common/widget/asset_image_view.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class VoteBox extends StatelessWidget {
  final int vote;

  const VoteBox({super.key, required this.vote});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.dimen_16,
            vertical: Dimens.dimen_8,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.1),
            borderRadius: BorderRadius.circular(Dimens.dimen_8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AssetImageView(
                fileName: 'arrow_up.png',
                color: Colors.white,
                width: Dimens.dimen_18,
                height: Dimens.dimen_18,
              ),
              SizedBox(
                width: Dimens.dimen_8,
              ),
              Text(
                vote.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontSize: Dimens.dimen_14,
                    ),
              ),
              SizedBox(width: Dimens.dimen_8),
              AssetImageView(
                fileName: 'arrow_down.png',
                color: Colors.white,
                width: Dimens.dimen_18,
                height: Dimens.dimen_18,
              ),
            ],
          ),
        )
      ],
    );
  }
}
