import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_adaptive_ui.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/binding/add_reminder_binding.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/route/add_reminder_argument.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/add_reminder_view_model.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/route/add_reminder_route.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/screen/add_reminder_mobile_portrait.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/screen/add_reminder_mobile_landscape.dart';

class AddReminderAdaptiveUi
    extends BaseAdaptiveUi<AddReminderArgument, AddReminderRoute> {
  const AddReminderAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => AddReminderAdaptiveUiState();
}

class AddReminderAdaptiveUiState extends BaseAdaptiveUiState<
    AddReminderArgument,
    AddReminderRoute,
    AddReminderAdaptiveUi,
    AddReminderViewModel,
    AddReminderBinding> {
  @override
  AddReminderBinding binding = AddReminderBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return AddReminderMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return AddReminderMobileLandscape(viewModel: viewModel);
  }
}
