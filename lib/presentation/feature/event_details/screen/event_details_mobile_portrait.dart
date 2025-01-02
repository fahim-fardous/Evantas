import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_ui_state.dart';
import 'package:hello_flutter/presentation/feature/event_details/event_details_view_model.dart';

class EventDetailsMobilePortrait extends StatefulWidget {
  final EventDetailsViewModel viewModel;

  const EventDetailsMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => EventDetailsMobilePortraitState();
}

class EventDetailsMobilePortraitState extends BaseUiState<EventDetailsMobilePortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: valueListenableBuilder(
        listenable: widget.viewModel.message,
        builder: (context, value) {
          return InkWell(
            child: Text('EventDetails: $value'),
            onTap: () => widget.viewModel.onClick(),
          );
        },
      ),
    );
  }
}
