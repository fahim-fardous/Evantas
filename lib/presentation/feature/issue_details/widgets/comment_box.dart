import 'package:evntas/presentation/common/widget/asset_image_view.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final int commentCount;

  const CommentBox({
    super.key,
    required this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.dimen_8,
        vertical: Dimens.dimen_6,
      ),
      decoration: BoxDecoration(
        color: AppColors.of(context).mainColor.withOpacity(.8),
        borderRadius: BorderRadius.circular(Dimens.dimen_32),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AssetImageView(
            fileName: 'comment.png',
            width: Dimens.dimen_20,
            height: Dimens.dimen_20,
            color: Colors.white,
          ),
          SizedBox(width: Dimens.dimen_8),
          Text(
            commentCount.toString(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontSize: Dimens.dimen_14,
                ),
          ),
        ],
      ),
    );
  }
}
