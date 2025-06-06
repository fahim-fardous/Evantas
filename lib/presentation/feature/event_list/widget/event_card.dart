import 'package:domain/model/event.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/common/extension/event_type_ext.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: event.date.isBefore(DateTime.now())
          ? Dimens.dimen_1 / Dimens.dimen_2
          : Dimens.dimen_1,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: Dimens.dimen_8,
          vertical: Dimens.dimen_4,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(Dimens.dimen_8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: Dimens.dimen_0,
              blurRadius: Dimens.dimen_2,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimens.dimen_16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(Dimens.dimen_8),
                        decoration: BoxDecoration(
                          color: event.date.isBefore(DateTime.now()) ? Colors.grey : AppColors.of(context).mainColor,
                          borderRadius: BorderRadius.circular(Dimens.dimen_48),
                        ),
                        child: Icon(
                          event.eventType.getEventIcon(),
                          color: Colors.black,
                          size: Dimens.dimen_24,
                        ),
                      ),
                      SizedBox(width: Dimens.dimen_8),
                      Text(
                        event.title,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: event.date.isBefore(DateTime.now()) ? Colors.grey : AppColors.of(context).mainColor,
                              fontSize: Dimens.dimen_16,
                              fontFamily: 'Roboto',
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Dimens.dimen_16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      event.description ?? '',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: event.date.isBefore(DateTime.now()) ? Colors.grey : AppColors.of(context).mainColor,
                            fontFamily: 'Roboto',
                            fontSize: Dimens.dimen_18,
                          ),
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(width: Dimens.dimen_16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
