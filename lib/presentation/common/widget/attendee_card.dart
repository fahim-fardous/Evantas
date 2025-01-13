import 'package:domain/model/event.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';
import 'asset_image_view.dart';

class AttendeeCard extends StatelessWidget {
  final Event event;
  final int maxVisible;
  final bool shouldShowPlus;

  const AttendeeCard({
    super.key,
    required this.event,
    this.maxVisible = 2,
    required this.shouldShowPlus,
  });

  @override
  Widget build(BuildContext context) {
    final hasExtraAttendees = event.attendees.length > maxVisible;
    final stackWidth = (Dimens.dimen_20 * (maxVisible - 1)) + Dimens.dimen_36;

    return SizedBox(
      height: Dimens.dimen_36,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: stackWidth + (hasExtraAttendees && shouldShowPlus ? Dimens.dimen_20 : 0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                for (int i = 0; i < event.attendees.length && i < maxVisible; i++)
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
                        ),
                      ),
                      child: ClipOval(
                        child: AssetImageView(
                          fileName: event.attendees[i].profilePhotoUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                if (hasExtraAttendees && shouldShowPlus)
                  Positioned(
                    left: maxVisible * Dimens.dimen_20,
                    child: Container(
                      width: Dimens.dimen_36,
                      height: Dimens.dimen_36,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: Dimens.dimen_1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '+${event.attendees.length - maxVisible}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimens.dimen_14,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (hasExtraAttendees && !shouldShowPlus) ...[
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${event.attendees[0].name.split(' ')[0]}, ${event.attendees[1].name.split(' ')[0]} & ${event.attendees.length - maxVisible} more',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}