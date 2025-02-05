import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_ui_state.dart';
import 'package:hello_flutter/presentation/common/extension/context_ext.dart';
import 'package:hello_flutter/presentation/common/widget/asset_image_view.dart';
import 'package:hello_flutter/presentation/common/widget/primary_button.dart';
import 'package:hello_flutter/presentation/feature/event_details/event_details_view_model.dart';
import 'package:hello_flutter/presentation/theme/color/app_colors.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';
import 'package:intl/intl.dart';

class EventDetailsMobilePortrait extends StatefulWidget {
  final EventDetailsViewModel viewModel;

  const EventDetailsMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => EventDetailsMobilePortraitState();
}

class EventDetailsMobilePortraitState
    extends BaseUiState<EventDetailsMobilePortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return valueListenableBuilder(
      listenable: widget.viewModel.event,
      builder: (context, event) => Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => widget.viewModel.onBackButtonPressed(),
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.of(context).mainColor,
                ),
              ),
              SizedBox(width: Dimens.dimen_36),
            ],
          ),
          valueListenableBuilder(
            listenable: widget.viewModel.event,
            builder: (context, event) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.dimen_16,
                vertical: Dimens.dimen_8,
              ),
              decoration: BoxDecoration(
                color: AppColors.of(context).mainColor,
                borderRadius: BorderRadius.circular(Dimens.dimen_24),
              ),
              child: Text(
                DateFormat('EEEE, dd MMMM')
                    .format(event?.date ?? DateTime.now()),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimens.dimen_16,
          right: Dimens.dimen_16,
          bottom: Dimens.dimen_16,
        ),
        child: valueListenableBuilder(
          listenable: widget.viewModel.event,
          builder: (context, event) => Column(
            children: [
              _buildAppBar(context),
              SizedBox(height: Dimens.dimen_16),
              (event != null)
                  ? Container(
                      padding: EdgeInsets.only(
                        left: Dimens.dimen_16,
                        right: Dimens.dimen_16,
                        top: Dimens.dimen_48,
                        bottom: Dimens.dimen_64,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(Dimens.dimen_32),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimens.dimen_16),
                            child: _buildEventHeader(context),
                          ),
                          SizedBox(height: Dimens.dimen_16),
                          _buildEventTime(context),
                          SizedBox(height: Dimens.dimen_24),
                          valueListenableBuilder(
                            listenable: widget.viewModel.event,
                            builder: (context, event) => Text(
                              event?.title ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: Dimens.dimen_16),
                          _buildEventImageView(context),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              const Spacer(),
              (event != null)
                  ? _buildPrimaryButton(context)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(Dimens.dimen_8),
          alignment: Alignment.center,
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
        valueListenableBuilder(
          listenable: widget.viewModel.event,
          builder: (context, event) => Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.dimen_24,
              vertical: Dimens.dimen_10,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Dimens.dimen_48),
            ),
            alignment: Alignment.center,
            child: Text(
              event?.title ?? '',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            size: Dimens.dimen_24,
          ),
        ),
      ],
    );
  }

  Widget _buildEventTime(BuildContext context) {
    return valueListenableBuilder(
      listenable: widget.viewModel.event,
      builder: (context, event) => Text(
        DateFormat('EEE, d MMMM, hh:mm a').format(
          event?.date ?? DateTime.now(),
        ),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey,
            ),
      ),
    );
  }

  Widget _buildEventImageView(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.dimen_16),
      child: SizedBox(
        width: double.infinity,
        height: Dimens.dimen_200,
        child: const AssetImageView(
          fileName: 'team_dinner.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return PrimaryButton(
      label: context.localizations.join_the_event,
      onPressed: () {},
      minWidth: double.infinity,
      buttonColor: AppColors.of(context).mainColor,
    );
  }
}
