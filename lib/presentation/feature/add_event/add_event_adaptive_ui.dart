import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_adaptive_ui.dart';
import 'package:hello_flutter/presentation/feature/add_event/binding/add_event_binding.dart';
import 'package:hello_flutter/presentation/feature/add_event/route/add_event_argument.dart';
import 'package:hello_flutter/presentation/feature/add_event/add_event_view_model.dart';
import 'package:hello_flutter/presentation/feature/add_event/route/add_event_route.dart';
import 'package:hello_flutter/presentation/feature/add_event/screen/add_event_mobile_portrait.dart';
import 'package:hello_flutter/presentation/feature/add_event/screen/add_event_mobile_landscape.dart';

class AddEventAdaptiveUi extends BaseAdaptiveUi<AddEventArgument, AddEventRoute> {
  const AddEventAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => AddEventAdaptiveUiState();
}

class AddEventAdaptiveUiState extends BaseAdaptiveUiState<AddEventArgument, AddEventRoute, AddEventAdaptiveUi, AddEventViewModel, AddEventBinding> {
  @override
  AddEventBinding binding = AddEventBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return AddEventMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return AddEventMobileLandscape(viewModel: viewModel);
  }
}
