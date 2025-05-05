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
            fileName: 'comment.png',
            width: Dimens.dimen_20,
            height: Dimens.dimen_20,
            color: Colors.white,
          ),
          SizedBox(width: Dimens.dimen_8),
          Text(
            "Comment",
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
