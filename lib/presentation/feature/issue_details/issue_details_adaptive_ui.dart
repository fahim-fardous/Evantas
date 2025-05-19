import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_adaptive_ui.dart';
import 'package:evntas/presentation/feature/issue_details/binding/issue_details_binding.dart';
import 'package:evntas/presentation/feature/issue_details/route/issue_details_argument.dart';
import 'package:evntas/presentation/feature/issue_details/issue_details_view_model.dart';
import 'package:evntas/presentation/feature/issue_details/route/issue_details_route.dart';
import 'package:evntas/presentation/feature/issue_details/screen/issue_details_mobile_portrait.dart';
import 'package:evntas/presentation/feature/issue_details/screen/issue_details_mobile_landscape.dart';

class IssueDetailsAdaptiveUi
    extends BaseAdaptiveUi<IssueDetailsArgument, IssueDetailsRoute> {
  const IssueDetailsAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => IssueDetailsAdaptiveUiState();
}

class IssueDetailsAdaptiveUiState extends BaseAdaptiveUiState<
    IssueDetailsArgument,
    IssueDetailsRoute,
    IssueDetailsAdaptiveUi,
    IssueDetailsViewModel,
    IssueDetailsBinding> {
  @override
  IssueDetailsBinding binding = IssueDetailsBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return IssueDetailsMobilePortrait(
      viewModel: viewModel,
      issueId: widget.argument?.issueId ?? 0,
    );
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return IssueDetailsMobileLandscape(
      viewModel: viewModel,
      issueId: widget.argument?.issueId ?? 0,
    );
  }
}
