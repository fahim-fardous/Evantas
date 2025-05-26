import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_adaptive_ui.dart';
import 'package:evntas/presentation/feature/points/binding/points_binding.dart';
import 'package:evntas/presentation/feature/points/route/points_argument.dart';
import 'package:evntas/presentation/feature/points/points_view_model.dart';
import 'package:evntas/presentation/feature/points/route/points_route.dart';
import 'package:evntas/presentation/feature/points/screen/points_mobile_portrait.dart';
import 'package:evntas/presentation/feature/points/screen/points_mobile_landscape.dart';

class PointsAdaptiveUi extends BaseAdaptiveUi<PointsArgument, PointsRoute> {
  const PointsAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => PointsAdaptiveUiState();
}

class PointsAdaptiveUiState extends BaseAdaptiveUiState<PointsArgument, PointsRoute, PointsAdaptiveUi, PointsViewModel, PointsBinding> {
  @override
  PointsBinding binding = PointsBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return PointsMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return PointsMobileLandscape(viewModel: viewModel);
  }
}
