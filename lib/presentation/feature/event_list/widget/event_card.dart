import 'package:domain/model/event.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/common/extension/event_type_ext.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final bool hasTopRightAction;

  const EventCard({
    super.key,
    required this.event,
    this.hasTopRightAction = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final eventDateTime = DateTime(
      event.date.year,
      event.date.month,
      event.date.day,
      event.time.hour,
      event.time.minute,
    );
    final isPast = eventDateTime.isBefore(DateTime.now());
    final mainColor = AppColors.of(context).mainColor;
    final baseSurface = isDark
        ? Theme.of(context).colorScheme.surface.withOpacity(.32)
        : Theme.of(context).colorScheme.surface;
    final titleColor = isPast
        ? Theme.of(context).colorScheme.outline
        : Theme.of(context).colorScheme.onSurface;
    final mutedColor = Theme.of(context).colorScheme.outline;

    return Opacity(
      opacity: isPast ? .84 : 1,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: Dimens.dimen_8,
          vertical: Dimens.dimen_4,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [baseSurface, Theme.of(context).colorScheme.surface.withOpacity(.2)]
                : [
                    baseSurface,
                    Theme.of(context).colorScheme.surfaceContainerLowest,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(Dimens.dimen_16),
          border: Border.all(
            color: isPast
                ? Theme.of(context).colorScheme.outlineVariant.withOpacity(.45)
                : mainColor.withOpacity(isDark ? .28 : .18),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(.28)
                  : mainColor.withOpacity(.08),
              spreadRadius: Dimens.dimen_0,
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimens.dimen_16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(right: hasTopRightAction ? Dimens.dimen_28 : 0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(Dimens.dimen_8),
                      decoration: BoxDecoration(
                        color: isPast
                            ? Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest
                                .withOpacity(.6)
                            : mainColor.withOpacity(.14),
                        borderRadius: BorderRadius.circular(Dimens.dimen_48),
                        border: Border.all(
                          color: isPast
                              ? Theme.of(context).colorScheme.outlineVariant
                              : mainColor.withOpacity(.35),
                        ),
                      ),
                      child: Icon(
                        event.eventType.getEventIcon(),
                        color: isPast ? mutedColor : mainColor,
                        size: Dimens.dimen_20,
                      ),
                    ),
                    SizedBox(width: Dimens.dimen_8),
                    Expanded(
                      child: Text(
                        event.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: titleColor,
                              fontSize: Dimens.dimen_18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimens.dimen_12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.description ?? '',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: isPast
                                    ? mutedColor
                                    : Theme.of(context).colorScheme.onSurfaceVariant,
                                fontFamily: 'Roboto',
                                height: 1.3,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: Dimens.dimen_10),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimens.dimen_10,
                                vertical: Dimens.dimen_6,
                              ),
                              decoration: BoxDecoration(
                                color: isPast
                                    ? Theme.of(context)
                                        .colorScheme
                                        .surfaceContainerHighest
                                        .withOpacity(.55)
                                    : mainColor.withOpacity(.12),
                                borderRadius: BorderRadius.circular(Dimens.dimen_100),
                              ),
                              child: Text(
                                isPast ? 'Past Event' : 'Upcoming',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: isPast ? mutedColor : mainColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              DateFormat('h:mm a').format(eventDateTime),
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: isPast
                                        ? mutedColor
                                        : Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
