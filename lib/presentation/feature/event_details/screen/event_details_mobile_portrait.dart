import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_ui_state.dart';
import 'package:hello_flutter/presentation/common/extension/context_ext.dart';
import 'package:hello_flutter/presentation/feature/event_details/event_details_view_model.dart';
import 'package:hello_flutter/presentation/theme/color/app_colors.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';

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
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.of(context).mainColor,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_16),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_16),
            child: Row(
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
                Container(
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
                    'MT-15 DINNER',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      size: Dimens.dimen_24,
                    ))
              ],
            ),
          ),
          SizedBox(height: Dimens.dimen_16),
          Text(
            'Mon 8th, 2025, 8:30 PM',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
}
