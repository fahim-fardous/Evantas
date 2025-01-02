import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_adaptive_ui.dart';
import 'package:hello_flutter/presentation/feature/event_list/binding/event_list_binding.dart';
import 'package:hello_flutter/presentation/feature/event_list/route/event_list_argument.dart';
import 'package:hello_flutter/presentation/feature/event_list/event_list_view_model.dart';
import 'package:hello_flutter/presentation/feature/event_list/route/event_list_route.dart';
import 'package:hello_flutter/presentation/feature/event_list/screen/event_list_mobile_portrait.dart';
import 'package:hello_flutter/presentation/feature/event_list/screen/event_list_mobile_landscape.dart';

class EventListAdaptiveUi extends BaseAdaptiveUi<EventListArgument, EventListRoute> {
  const EventListAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => EventListAdaptiveUiState();
}

class EventListAdaptiveUiState extends BaseAdaptiveUiState<EventListArgument, EventListRoute, EventListAdaptiveUi, EventListViewModel, EventListBinding> {
  @override
  EventListBinding binding = EventListBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return EventListMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return EventListMobileLandscape(viewModel: viewModel);
  }
}
