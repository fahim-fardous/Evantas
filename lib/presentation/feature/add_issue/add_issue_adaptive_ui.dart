import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_adaptive_ui.dart';
import 'package:evntas/presentation/feature/add_issue/binding/add_issue_binding.dart';
import 'package:evntas/presentation/feature/add_issue/route/add_issue_argument.dart';
import 'package:evntas/presentation/feature/add_issue/add_issue_view_model.dart';
import 'package:evntas/presentation/feature/add_issue/route/add_issue_route.dart';
import 'package:evntas/presentation/feature/add_issue/screen/add_issue_mobile_portrait.dart';
import 'package:evntas/presentation/feature/add_issue/screen/add_issue_mobile_landscape.dart';

class AddIssueAdaptiveUi extends BaseAdaptiveUi<AddIssueArgument, AddIssueRoute> {
  const AddIssueAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => AddIssueAdaptiveUiState();
}

class AddIssueAdaptiveUiState extends BaseAdaptiveUiState<AddIssueArgument, AddIssueRoute, AddIssueAdaptiveUi, AddIssueViewModel, AddIssueBinding> {
  @override
  AddIssueBinding binding = AddIssueBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return AddIssueMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return AddIssueMobileLandscape(viewModel: viewModel);
  }
}
