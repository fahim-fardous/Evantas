import 'package:domain/model/event_type.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/common/extension/context_ext.dart';
import 'package:hello_flutter/presentation/feature/create_feature.dart';
import 'package:hello_flutter/presentation/theme/color/app_colors.dart';
import 'package:hello_flutter/presentation/values/dimens.dart';

class ReminderEventTypeField extends StatelessWidget {
  final List<EventType> eventTypes;
  final EventType? selectedEventType;
  final void Function(EventType) onChanged;

  const ReminderEventTypeField({
    super.key,
    required this.eventTypes,
    required this.selectedEventType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<EventType>(
      value: selectedEventType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dimens.dimen_16,
          vertical: Dimens.dimen_12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        labelText: context.localizations.event_type_label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_8),
          borderSide: BorderSide(
            color: AppColors.of(context).primary,
            width: Dimens.dimen_2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_8),
          borderSide: BorderSide(
            color: AppColors.of(context).outlineVariant,
            width: Dimens.dimen_2,
          ),
        ),
      ),
      style: const TextStyle(color: Colors.black),
      icon: const Icon(Icons.arrow_drop_down),
      dropdownColor: Colors.white,
      onChanged: (EventType? eventType) =>
          eventType != null ? onChanged(eventType) : onChanged,
      items: eventTypes.map((eventType) {
        return DropdownMenuItem<EventType>(
          value: eventType,
          child: Text(eventType.name.capitalize()),
        );
      }).toList(),
    );
  }
}
