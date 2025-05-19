import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/model/comment.dart';
import 'package:domain/model/user_response_data.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final Comment comment;
  final UserResponseData user;

  const CommentBox({
    super.key,
    required this.comment,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: user.photoUrl,
            width: Dimens.dimen_32,
            height: Dimens.dimen_32,
          ),
        ),
        SizedBox(width: Dimens.dimen_8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name, style: Theme.of(context).textTheme.labelMedium),
            SizedBox(height: Dimens.dimen_8),
            Text(comment.comment),
          ],
        ),
      ],
    );
  }
}
