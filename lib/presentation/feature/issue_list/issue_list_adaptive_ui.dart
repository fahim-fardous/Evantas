import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_adaptive_ui.dart';
import 'package:evntas/presentation/feature/issue_list/binding/issue_list_binding.dart';
import 'package:evntas/presentation/feature/issue_list/route/issue_list_argument.dart';
import 'package:evntas/presentation/feature/issue_list/issue_list_view_model.dart';
import 'package:evntas/presentation/feature/issue_list/route/issue_list_route.dart';
import 'package:evntas/presentation/feature/issue_list/screen/issue_list_mobile_portrait.dart';
import 'package:evntas/presentation/feature/issue_list/screen/issue_list_mobile_landscape.dart';

class IssueListAdaptiveUi extends BaseAdaptiveUi<IssueListArgument, IssueListRoute> {
  const IssueListAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => IssueListAdaptiveUiState();
}

class IssueListAdaptiveUiState extends BaseAdaptiveUiState<IssueListArgument, IssueListRoute, IssueListAdaptiveUi, IssueListViewModel, IssueListBinding> {
  @override
  IssueListBinding binding = IssueListBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return IssueListMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return IssueListMobileLandscape(viewModel: viewModel);
  }
}
