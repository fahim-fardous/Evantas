import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_ui_state.dart';
import 'package:hello_flutter/presentation/common/extension/context_ext.dart';
import 'package:hello_flutter/presentation/common/widget/asset_image_view.dart';
import 'package:hello_flutter/presentation/feature/event_list/event_list_view_model.dart';
import 'package:hello_flutter/presentation/feature/event_list/widget/event_card.dart';
import 'package:hello_flutter/presentation/feature/event_list/widget/event_type_item.dart';
import 'package:hello_flutter/presentation/theme/color/app_colors.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              SizedBox(height: Dimens.dimen_16),
              _buildEventProgressCard(context),
              SizedBox(height: Dimens.dimen_16),
              _buildEventTypes(context),
              SizedBox(
                height: Dimens.dimen_16,
              ),
              _buildEventList(context),
            ],
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
            SizedBox(
              height: Dimens.dimen_4,
            ),
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
      onPressed: () {},
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
        color: AppColors.of(context).mainColor.withOpacity(.25),
        borderRadius: BorderRadius.circular(Dimens.dimen_16),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You Have 5',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color:
                          Theme.of(context).colorScheme.scrim.withOpacity(.4),
                      fontSize: Dimens.dimen_28,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Upcoming Events',
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
    );
  }

  Widget _buildEventTypes(BuildContext context) {
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
                      child: EventType(
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
      valueListenable: widget.viewModel.events,
      builder: (context, events, child) => Column(
        children: events
            .asMap()
            .entries
            .map((entry) => GestureDetector(
                onTap: () => widget.viewModel.onEventClicked(),
                child: EventCard(event: entry.value)))
            .toList(),
      ),
    );
  }
}
