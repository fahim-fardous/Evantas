import 'package:evntas/presentation/common/widget/asset_image_view.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class VoteBox extends StatelessWidget {
  final int issueId;
  final int upvote;
  final int downvote;
  final Function(int) onLikeTap;
  final Function(int) onDislikeTap;

  const VoteBox({
    super.key,
    required this.issueId,
    required this.upvote,
    required this.downvote,
    required this.onLikeTap,
    required this.onDislikeTap,
  });

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
              GestureDetector(
                onTap: () => onLikeTap(issueId),
                child: AssetImageView(
                  fileName: 'like_icon.png',
                  color: Theme.of(context).colorScheme.primary,
                  width: Dimens.dimen_18,
                  height: Dimens.dimen_18,
                ),
              ),
              SizedBox(
                width: Dimens.dimen_8,
              ),
              Text(
                upvote.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: Dimens.dimen_14,
                    ),
              ),
              SizedBox(width: Dimens.dimen_8),
              GestureDetector(
                onTap: () => onDislikeTap(issueId),
                child: AssetImageView(
                  fileName: 'dislike_icon.png',
                  color: Theme.of(context).colorScheme.primary,
                  width: Dimens.dimen_18,
                  height: Dimens.dimen_18,
                ),
              ),
              SizedBox(
                width: Dimens.dimen_8,
              ),
              Text(
                downvote.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: Dimens.dimen_14,
                    ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
