import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_adaptive_ui.dart';
import 'package:evntas/presentation/feature/memory/binding/memory_binding.dart';
import 'package:evntas/presentation/feature/memory/route/memory_argument.dart';
import 'package:evntas/presentation/feature/memory/memory_view_model.dart';
import 'package:evntas/presentation/feature/memory/route/memory_route.dart';
import 'package:evntas/presentation/feature/memory/screen/memory_mobile_portrait.dart';
import 'package:evntas/presentation/feature/memory/screen/memory_mobile_landscape.dart';

class MemoryAdaptiveUi extends BaseAdaptiveUi<MemoryArgument, MemoryRoute> {
  const MemoryAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => MemoryAdaptiveUiState();
}

class MemoryAdaptiveUiState extends BaseAdaptiveUiState<MemoryArgument, MemoryRoute, MemoryAdaptiveUi, MemoryViewModel, MemoryBinding> {
  @override
  MemoryBinding binding = MemoryBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return MemoryMobilePortrait(viewModel: viewModel);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return MemoryMobileLandscape(viewModel: viewModel);
  }
}
