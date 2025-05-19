import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/common/extension/context_ext.dart';
import 'package:evntas/presentation/common/extension/event_type_ext.dart';
import 'package:evntas/presentation/common/widget/asset_image_view.dart';
import 'package:evntas/presentation/feature/event_list/event_list_view_model.dart';
import 'package:evntas/presentation/feature/event_list/widget/event_card.dart';
import 'package:evntas/presentation/feature/event_list/widget/event_type_item.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/util/helper_function.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _buildFloatingActionButton(context),
      body: SafeArea(
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
                SizedBox(height: Dimens.dimen_16),
                _buildEventTypeSelector(context),
                SizedBox(height: Dimens.dimen_16),
                _buildEventList(context),
              ],
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
              context.localizations.welcome_back,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    fontSize: Dimens.dimen_16,
                    fontFamily: 'Roboto',
                  ),
            ),
            SizedBox(height: Dimens.dimen_4),
            Text(
              'Fahim',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.of(context).mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimens.dimen_28,
                    fontFamily: 'Roboto',
                  ),
            )
          ],
        ),
        AssetImageView(
          fileName: 'profile_avatar.png',
          width: Dimens.dimen_48,
          height: Dimens.dimen_48,
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.dimen_16,
        vertical: Dimens.dimen_36,
      ),
      decoration: BoxDecoration(
        color: AppColors.of(context).mainColor.withOpacity(.5),
        borderRadius: BorderRadius.circular(Dimens.dimen_16),
      ),
      child: valueListenableBuilder(
        listenable: widget.viewModel.events,
        builder: (context, events) => Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You Have ${events.length}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onPrimary,
                        fontSize: Dimens.dimen_28,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  (events.length > 1) ? 'Upcoming Events' : 'Upcoming Event',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.scrim,
                        fontSize: Dimens.dimen_28,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            Expanded(
              child: AssetImageView(
                fileName: 'progress_card_img.png',
                width: Dimens.dimen_128,
                height: Dimens.dimen_128,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEventTypeSelector(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.viewModel.eventTypes,
      builder: (context, eventTypes, child) => ValueListenableBuilder(
        valueListenable: widget.viewModel.currentIndex,
        builder: (context, int index, child) => Row(
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
                      SizedBox(width: Dimens.dimen_16),
                  ],
                ),
              )
              .toList(),
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

            final groupedEvents =
                HelperFunction.groupEventsByDate(filteredEvents);

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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimens.dimen_16,
                        vertical: Dimens.dimen_16,
                      ),
                      child: Text(
                        DateFormat('d MMMM').format(date),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                    ...eventList.map(
                      (entry) => GestureDetector(
                        onTap: () =>
                            widget.viewModel.onEventClicked(eventId: entry.id),
                        child: EventCard(event: entry),
                      ),
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
}
