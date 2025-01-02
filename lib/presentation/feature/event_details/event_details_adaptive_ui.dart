import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_adaptive_ui.dart';
import 'package:hello_flutter/presentation/feature/event_details/binding/event_details_binding.dart';
import 'package:hello_flutter/presentation/feature/event_details/route/event_details_argument.dart';
import 'package:hello_flutter/presentation/feature/event_details/event_details_view_model.dart';
import 'package:hello_flutter/presentation/feature/event_details/route/event_details_route.dart';
import 'package:hello_flutter/presentation/feature/event_details/screen/event_details_mobile_portrait.dart';
import 'package:hello_flutter/presentation/feature/event_details/screen/event_details_mobile_landscape.dart';

class EventDetailsAdaptiveUi extends BaseAdaptiveUi<EventDetailsArgument, EventDetailsRoute> {
  const EventDetailsAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => EventDetailsAdaptiveUiState();
}

class EventDetailsAdaptiveUiState extends BaseAdaptiveUiState<EventDetailsArgument, EventDetailsRoute, EventDetailsAdaptiveUi, EventDetailsViewModel, EventDetailsBinding> {
  @override
  EventDetailsBinding binding = EventDetailsBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return EventDetailsMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return EventDetailsMobileLandscape(viewModel: viewModel);
  }
}
