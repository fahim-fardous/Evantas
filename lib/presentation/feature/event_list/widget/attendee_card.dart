import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/common/widget/asset_image_view.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';

class AttendeeCard extends StatelessWidget {
  final List<String> attendeeUrls;
  final int maxVisible = 2;

  const AttendeeCard({
    super.key,
    required this.attendeeUrls,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.dimen_20,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          for (int i = 0; i < attendeeUrls.length && i < maxVisible; i++)
            Positioned(
              left: i * Dimens.dimen_20,
              child: Container(
                width: Dimens.dimen_36,
                height: Dimens.dimen_36,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: Dimens.dimen_1,
                    )),
                child: ClipOval(
                  child: AssetImageView(
                    fileName: attendeeUrls[i],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          if (attendeeUrls.length > maxVisible)
            Positioned(
              left: maxVisible * Dimens.dimen_20,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: Dimens.dimen_36,
                    height: Dimens.dimen_36,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: Dimens.dimen_1,
                        )),
                  ),
                  Text(
                    '+${attendeeUrls.length - maxVisible}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimens.dimen_14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
