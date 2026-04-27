import 'dart:collection';

import 'package:domain/model/event.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/common/extension/context_ext.dart';
import 'package:evntas/presentation/common/extension/event_type_ext.dart';
import 'package:evntas/presentation/common/widget/asset_image_view.dart';
import 'package:evntas/presentation/feature/event_list/event_list_view_model.dart';
import 'package:evntas/presentation/feature/event_list/widget/event_card.dart';
import 'package:evntas/presentation/feature/event_list/widget/event_type_item.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:intl/intl.dart';

class EventListMobilePortrait extends StatefulWidget {
  final EventListViewModel viewModel;

  const EventListMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => EventListMobilePortraitState();
}

class EventListMobilePortraitState
    extends BaseUiState<EventListMobilePortrait> {
  bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  DateTime get _todayStart {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime _eventDateTime(dynamic event) {
    return DateTime(
      event.date.year,
      event.date.month,
      event.date.day,
      event.time.hour,
      event.time.minute,
    );
  }

  Map<DateTime, List<dynamic>> _groupEventsByDatePreservingOrder(
    List<dynamic> events,
  ) {
    final groupedEvents = LinkedHashMap<DateTime, List<dynamic>>();
    for (final event in events) {
      final dateKey = DateTime(event.date.year, event.date.month, event.date.day);
      groupedEvents.putIfAbsent(dateKey, () => []).add(event);
    }
    return groupedEvents;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _isDark(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildFloatingActionButton(context),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      const Color(0xFF050816),
                      const Color(0xFF0A1326),
                      const Color(0xFF070B17),
                    ]
                  : [
                      Theme.of(context).colorScheme.surface,
                      Theme.of(context).colorScheme.surfaceContainerLowest,
                      Theme.of(context).colorScheme.background,
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(Dimens.dimen_16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(context),
                  SizedBox(height: Dimens.dimen_16),
                  _buildEventProgressCard(context),
                  SizedBox(height: Dimens.dimen_12),
                  _buildStatsRow(context),
                  SizedBox(height: Dimens.dimen_20),
                  _buildSectionTitle(context),
                  SizedBox(height: Dimens.dimen_12),
                  _buildEventTypeSelector(context),
                  SizedBox(height: Dimens.dimen_16),
                  _buildEventList(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isDark(context) ? 'GOOD EVENING' : context.localizations.welcome_back,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                    letterSpacing: 1.1,
                    fontSize: Dimens.dimen_13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: Dimens.dimen_4),
            Text(
              'Fahim',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.of(context).mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimens.dimen_32,
                    fontFamily: 'Roboto',
                  ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.all(Dimens.dimen_3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.of(context).mainColor.withOpacity(
                _isDark(context) ? .75 : .35,
              ),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.of(context).mainColor.withOpacity(
                  _isDark(context) ? .22 : .12,
                ),
                blurRadius: _isDark(context) ? 18 : 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: AssetImageView(
            fileName: 'profile_avatar.png',
            width: Dimens.dimen_48,
            height: Dimens.dimen_48,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.of(context).mainColor,
      onPressed: () => widget.viewModel.onAddEventButtonClicked(),
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _buildEventProgressCard(BuildContext context) {
    final isDark = _isDark(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.of(context).mainColor.withOpacity(isDark ? .38 : .95),
            isDark
                ? const Color(0xFF122A40).withOpacity(.9)
                : AppColors.of(context).mainColor.withOpacity(.72),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(Dimens.dimen_16),
        border: Border.all(
          color: isDark
              ? AppColors.of(context).mainColor.withOpacity(.38)
              : Colors.white.withOpacity(.24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).mainColor.withOpacity(isDark ? .18 : .25),
            blurRadius: isDark ? 24 : 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -10,
            child: Container(
              width: Dimens.dimen_90,
              height: Dimens.dimen_90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.12),
              ),
            ),
          ),
          Positioned(
            bottom: -25,
            left: -5,
            child: Container(
              width: Dimens.dimen_70,
              height: Dimens.dimen_70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.08),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.dimen_16,
              vertical: Dimens.dimen_24,
            ),
            child: valueListenableBuilder(
              listenable: widget.viewModel.events,
              builder: (context, events) => Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Event Overview',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withOpacity(.9),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: .8,
                                  ),
                        ),
                        SizedBox(height: Dimens.dimen_8),
                        valueListenableBuilder(
                          listenable: widget.viewModel.upcomingEvents,
                          builder: (context, upcomingEvents) => Text(
                            'You Have ${upcomingEvents.length}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        SizedBox(height: Dimens.dimen_4),
                        Text(
                          (events.length > 1)
                              ? 'Upcoming Events'
                              : 'Upcoming Event',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white.withOpacity(.93),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        SizedBox(height: Dimens.dimen_14),
                        InkWell(
                          borderRadius: BorderRadius.circular(Dimens.dimen_100),
                          onTap: () => widget.viewModel.onAddEventButtonClicked(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimens.dimen_14,
                              vertical: Dimens.dimen_8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(isDark ? .14 : .2),
                              borderRadius: BorderRadius.circular(Dimens.dimen_100),
                              border: Border.all(
                                color: Colors.white.withOpacity(.2),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.add_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: Dimens.dimen_6),
                                Text(
                                  'Add Event',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AssetImageView(
                    fileName: 'progress_card_img.png',
                    width: Dimens.dimen_110,
                    height: Dimens.dimen_110,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return valueListenableBuilder(
      listenable: widget.viewModel.events,
      builder: (context, events) {
        final total = events.length;
        final now = DateTime.now();
        final upcoming = events.where((e) => !_eventDateTime(e).isBefore(now)).length;
        final past = events.where((e) => _eventDateTime(e).isBefore(now)).length;
        return Row(
          children: [
            Expanded(
              child: _buildStatCard(context, 'TOTAL', total, AppColors.of(context).mainColor),
            ),
            SizedBox(width: Dimens.dimen_10),
            Expanded(
              child: _buildStatCard(
                context,
                'UPCOMING',
                upcoming,
                const Color(0xFF5C7CFA),
              ),
            ),
            SizedBox(width: Dimens.dimen_10),
            Expanded(
              child: _buildStatCard(
                context,
                'PAST',
                past,
                const Color(0xFFE56B6F),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    int count,
    Color accent,
  ) {
    final isDark = _isDark(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.dimen_12,
        vertical: Dimens.dimen_12,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? Theme.of(context).colorScheme.surface.withOpacity(.45)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Dimens.dimen_16),
        border: Border.all(
          color: isDark
              ? accent.withOpacity(.4)
              : Theme.of(context).colorScheme.outlineVariant.withOpacity(.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 3,
            width: Dimens.dimen_30,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(Dimens.dimen_16),
            ),
          ),
          SizedBox(height: Dimens.dimen_8),
          Text(
            '$count',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          SizedBox(height: Dimens.dimen_2),
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                  letterSpacing: .8,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Events',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        Text(
          'See all',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.of(context).mainColor,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }

  Widget _buildEventTypeSelector(BuildContext context) {
    final isDark = _isDark(context);
    final containerColor = isDark
        ? Theme.of(context).colorScheme.surface.withOpacity(.35)
        : Theme.of(context).colorScheme.surface;
    return ValueListenableBuilder(
      valueListenable: widget.viewModel.eventTypes,
      builder: (context, eventTypes, child) => ValueListenableBuilder(
        valueListenable: widget.viewModel.currentIndex,
        builder: (context, int index, child) => Container(
          padding: EdgeInsets.all(Dimens.dimen_8),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(Dimens.dimen_100),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant.withOpacity(
                    isDark ? .25 : .4,
                  ),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: eventTypes
                  .asMap()
                  .entries
                  .map(
                    (entry) => Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => widget.viewModel.setCurrentIndex(entry.key),
                          child: EventTypeItem(
                            isSelected: index == entry.key,
                            name: entry.value.localizedString,
                          ),
                        ),
                        if (entry.key != eventTypes.length - 1)
                          SizedBox(width: Dimens.dimen_10),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventList(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.viewModel.currentIndex,
      builder: (context, eventType, child) {
        return ValueListenableBuilder(
          valueListenable: widget.viewModel.events,
          builder: (context, events, child) {
            final filteredEvents = events
                .where((event) => event.eventType.getEventIndex() == eventType)
                .toList();
            final now = DateTime.now();
            filteredEvents.sort((a, b) {
              final aDateTime = _eventDateTime(a);
              final bDateTime = _eventDateTime(b);
              final aIsPast = aDateTime.isBefore(now);
              final bIsPast = bDateTime.isBefore(now);

              // Upcoming events first; past events later.
              if (aIsPast != bIsPast) {
                return aIsPast ? 1 : -1;
              }

              if (aIsPast) {
                // For past events show latest first.
                return bDateTime.compareTo(aDateTime);
              }

              // For upcoming events show nearest first.
              return aDateTime.compareTo(bDateTime);
            });

            final groupedEvents =
                _groupEventsByDatePreservingOrder(filteredEvents);

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groupedEvents.keys.length,
              itemBuilder: (context, index) {
                final date = groupedEvents.keys.toList()[index];
                final eventList = groupedEvents[date]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: index == 0 ? 0 : Dimens.dimen_10,
                        bottom: Dimens.dimen_8,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimens.dimen_12,
                        vertical: Dimens.dimen_8,
                      ),
                      decoration: BoxDecoration(
                        color: _isDark(context)
                            ? Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest
                                .withOpacity(.36)
                            : Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.05),
                        borderRadius: BorderRadius.circular(Dimens.dimen_100),
                      ),
                      child: Text(
                        DateFormat('d MMMM, yyyy').format(date),
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    ...eventList.map(
                      (entry) {
                        final isPastEvent = _eventDateTime(entry).isBefore(DateTime.now());
                        return _buildEventItem(context, entry, isPastEvent);
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildEventItem(BuildContext context, dynamic entry, bool isPastEvent) {
    final event = entry as Event;
    final isDark = _isDark(context);
    final mainColor = AppColors.of(context).mainColor;
    return ValueListenableBuilder<String?>(
      valueListenable: widget.viewModel.currentUserId,
      builder: (context, _, __) {
        final isCreator = widget.viewModel.isEventCreatedByCurrentUser(event);
        return Padding(
          padding: EdgeInsets.only(bottom: Dimens.dimen_12),
          child: InkWell(
            borderRadius: BorderRadius.circular(Dimens.dimen_20),
            onTap: () => isPastEvent
                ? null
                : widget.viewModel.onEventClicked(event: event),
            child: Stack(
              children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimens.dimen_20),
                        gradient: LinearGradient(
                          colors: isDark
                              ? [
                                  Theme.of(context).colorScheme.surface.withOpacity(.48),
                                  Theme.of(context).colorScheme.surface.withOpacity(.28),
                                ]
                              : [
                                  Theme.of(context).colorScheme.surface,
                                  Theme.of(context).colorScheme.surfaceContainerLowest,
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: isPastEvent
                              ? Theme.of(context)
                                  .colorScheme
                                  .outlineVariant
                                  .withOpacity(.35)
                              : mainColor.withOpacity(isDark ? .28 : .20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isPastEvent
                                ? Colors.black.withOpacity(isDark ? .10 : .04)
                                : mainColor.withOpacity(isDark ? .16 : .10),
                            blurRadius: isPastEvent ? 10 : 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimens.dimen_20),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 180),
                          opacity: isPastEvent ? .88 : 1,
                          child: EventCard(
                            event: event,
                            hasTopRightAction: isCreator,
                          ),
                        ),
                      ),
                    ),
                    if (isPastEvent)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceVariant
                                  .withOpacity(.09),
                              borderRadius: BorderRadius.circular(Dimens.dimen_20),
                            ),
                          ),
                        ),
                      ),
                    if (isCreator)
                      Positioned(
                        top: Dimens.dimen_10,
                        right: Dimens.dimen_12,
                        child: PopupMenuButton<String>(
                          tooltip: 'Event actions',
                          padding: EdgeInsets.zero,
                          onSelected: (value) {
                            if (value == 'edit') {
                              widget.viewModel.onEditEventClicked(event: event);
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimens.dimen_12),
                          ),
                          itemBuilder: (context) => const [
                            PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit event details'),
                            ),
                          ],
                          icon: Icon(
                            Icons.more_vert_rounded,
                            size: Dimens.dimen_18,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                  ],
                ),
          ),
        );
      },
    );
  }

}
