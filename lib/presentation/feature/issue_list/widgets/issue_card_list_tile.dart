import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/model/issue.dart';
import 'package:evntas/presentation/common/widget/asset_image_view.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class IssueCardListTile extends StatelessWidget {
  final Issue issue;
  final Function(int) onTap;

  const IssueCardListTile({
    super.key,
    required this.issue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(issue.id),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimens.dimen_8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(
                Dimens.dimen_1 / Dimens.dimen_2,
              ),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            issue.issuePhotoUrl != null
                ? CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: issue.issuePhotoUrl!,
                    fit: BoxFit.cover,
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.only(
                left: Dimens.dimen_16,
                right: Dimens.dimen_16,
                top: Dimens.dimen_8,
              ),
              child: Text(
                issue.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(height: Dimens.dimen_8),
            Padding(
              padding: EdgeInsets.only(
                left: Dimens.dimen_16,
                right: Dimens.dimen_16,
                bottom: Dimens.dimen_8,
              ),
              child: Text(
                issue.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: Dimens.dimen_8),
            Padding(
              padding: EdgeInsets.only(
                left: Dimens.dimen_16,
                right: Dimens.dimen_16,
                bottom: Dimens.dimen_8,
              ),
              child: Row(children: [
                AssetImageView(
                  fileName: 'arrow_up.png',
                  width: Dimens.dimen_16,
                  height: Dimens.dimen_16,
                ),
                SizedBox(width: Dimens.dimen_8),
                Text(
                  '${issue.upvoteCount} votes',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                SizedBox(width: Dimens.dimen_16),
                AssetImageView(
                  fileName: 'arrow_down.png',
                  width: Dimens.dimen_16,
                  height: Dimens.dimen_16,
                ),
                SizedBox(width: Dimens.dimen_8),
                Text(
                  '${issue.downvoteCount} votes',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
