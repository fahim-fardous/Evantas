import 'package:domain/model/event.dart';
import 'package:flutter/material.dart';
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
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: Dimens.dimen_8,
        vertical: Dimens.dimen_4,
      ),
      child: Material(
        elevation: Dimens.dimen_1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_24),
        ),
        clipBehavior: Clip.antiAlias,
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
                          color: AppColors.of(context).mainColor,
                          borderRadius: BorderRadius.circular(Dimens.dimen_48),
                        ),
                        child: Icon(
                          Icons.dinner_dining,
                          color: Colors.black,
                          size: Dimens.dimen_24,
                        ),
                      ),
                      SizedBox(width: Dimens.dimen_8),
                      Text(
                        event.title,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.of(context).mainColor,
                              fontSize: Dimens.dimen_18,
                              fontFamily: 'Roboto',
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Dimens.dimen_24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      event.description ?? '',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.of(context).mainColor,
                            fontFamily: 'Roboto',
                            fontSize: Dimens.dimen_24,
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
