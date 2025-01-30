import 'package:domain/model/event_type.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_ui_state.dart';
import 'package:hello_flutter/presentation/common/extension/context_ext.dart';
import 'package:hello_flutter/presentation/common/widget/primary_button.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/add_reminder_view_model.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/widgets/reminder_date_field.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/widgets/reminder_event_type_field.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/widgets/reminder_text_field.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/widgets/reminder_time_field.dart';
import 'package:hello_flutter/presentation/theme/color/app_colors.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';

class AddReminderMobilePortrait extends StatefulWidget {
  final AddReminderViewModel viewModel;

  const AddReminderMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => AddReminderMobilePortraitState();
}

class AddReminderMobilePortraitState
    extends BaseUiState<AddReminderMobilePortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                    children: [
            _buildAppBar(context),
            SizedBox(height: Dimens.dimen_16),
            _buildBody(context),
                    ],
                  ),
          )),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => widget.viewModel.onBackButtonPressed(),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.of(context).mainColor,
          ),
        ),
        Text(
          'Add Reminder',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.of(context).mainColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimens.dimen_28,
                fontFamily: 'Roboto',
              ),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.dimen_16),
      child: Column(
        children: [
          _buildEventTitleField(context),
          SizedBox(height: Dimens.dimen_32),
          _buildEventDescriptionField(context),
          SizedBox(height: Dimens.dimen_32),
          _buildDateField(context),
          SizedBox(height: Dimens.dimen_32),
          _buildTimeField(context),
          SizedBox(height: Dimens.dimen_32),
          _buildEventTypeField(context),
          SizedBox(height: Dimens.dimen_32),
          _buildLocationField(context),
          SizedBox(height: Dimens.dimen_64),
          _buildSaveButton(context),
        ],
      ),
    );
  }

  Widget _buildEventTitleField(BuildContext context) {
    return ReminderTextField(
      labelText: context.localizations.event_title_label,
      hintText: context.localizations.event_title_hint_text,
    );
  }

  Widget _buildEventDescriptionField(BuildContext context) {
    return ReminderTextField(
      labelText: context.localizations.event_description_label,
      hintText: context.localizations.event_description_hint_text,
    );
  }

  Widget _buildDateField(BuildContext context) {
    return valueListenableBuilder(
      listenable: widget.viewModel.dateController,
      builder: (context, dateController) => ReminderDateField(
        controller: widget.viewModel.dateController,
        labelText: context.localizations.event_date_label,
        onDateSelected: (date) => widget.viewModel.onDateSelected(date),
      ),
    );
  }

  Widget _buildTimeField(BuildContext context) {
    return valueListenableBuilder(
      listenable: widget.viewModel.timeController,
      builder: (context, timeController) =>ReminderTimeField(
        controller: widget.viewModel.timeController,
        labelText: context.localizations.event_time_label,
        onTimeSelected: (date) => widget.viewModel.onTimeSelected(date),
      ),
    );
  }

  Widget _buildEventTypeField(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.viewModel.eventType,
      builder: (context, eventType, child) => ReminderEventTypeField(
        eventTypes: const [
          EventType.dinner,
          EventType.development,
          EventType.birthday,
          EventType.special
        ],
        onChanged: (eventType) =>
            widget.viewModel.onEventTypeSelected(eventType),
        selectedEventType: eventType,
      ),
    );
  }

  Widget _buildLocationField(BuildContext context) {
    return ReminderTextField(
      labelText: context.localizations.event_location_label,
      hintText: context.localizations.event_location_hint_text,
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return PrimaryButton(
      label: context.localizations.add_reminder__save_btn_text,
      onPressed: () => widget.viewModel.onSaveButtonClicked(),
      minWidth: double.infinity,
    );
  }
}
