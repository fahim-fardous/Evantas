import 'package:domain/model/event.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/common/widget/asset_image_view.dart';
import 'package:hello_flutter/presentation/feature/event_list/widget/attendee_card.dart';
import 'package:hello_flutter/presentation/theme/color/app_colors.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: Dimens.dimen_1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_24),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.dimen_8, vertical: Dimens.dimen_16),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(Dimens.dimen_16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimens.dimen_8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(Dimens.dimen_8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.of(context).mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimens.dimen_48),
                          ),
                          child: Icon(
                            Icons.dinner_dining,
                            color: Colors.black,
                            size: Dimens.dimen_24,
                          ),
                        ),
                        SizedBox(width: Dimens.dimen_8),
                        Text(
                          'MT-15 Dinner',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.of(context).mainColor,
                                    fontSize: Dimens.dimen_18,
                                    fontFamily: 'Poppins',
                                  ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Expanded(
                      child: AttendeeCard(
                          attendeeUrls: event.attendees
                              .map((e) => e.profilePhotoUrl)
                              .toList()),
                    )
                  ],
                ),
                SizedBox(height: Dimens.dimen_24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Mobile Team Dinner January, 2025',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.of(context).mainColor,
                              fontFamily: 'Poppins',
                            ),
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(width: Dimens.dimen_16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${(event.attendees.length / 15 * 100).floor()}%',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppColors.of(context).mainColor,
                                    fontFamily: 'Poppins',
                                  ),
                        ),
                        Text(
                          'Attending',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.grey,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
