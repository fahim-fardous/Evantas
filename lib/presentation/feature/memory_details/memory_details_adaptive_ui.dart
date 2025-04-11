import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_adaptive_ui.dart';
import 'package:hello_flutter/presentation/feature/memory_details/binding/memory_details_binding.dart';
import 'package:hello_flutter/presentation/feature/memory_details/route/memory_details_argument.dart';
import 'package:hello_flutter/presentation/feature/memory_details/memory_details_view_model.dart';
import 'package:hello_flutter/presentation/feature/memory_details/route/memory_details_route.dart';
import 'package:hello_flutter/presentation/feature/memory_details/screen/memory_details_mobile_portrait.dart';
import 'package:hello_flutter/presentation/feature/memory_details/screen/memory_details_mobile_landscape.dart';

class MemoryDetailsAdaptiveUi
    extends BaseAdaptiveUi<MemoryDetailsArgument, MemoryDetailsRoute> {
  const MemoryDetailsAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => MemoryDetailsAdaptiveUiState();
}

class MemoryDetailsAdaptiveUiState extends BaseAdaptiveUiState<
    MemoryDetailsArgument,
    MemoryDetailsRoute,
    MemoryDetailsAdaptiveUi,
    MemoryDetailsViewModel,
    MemoryDetailsBinding> {
  @override
  MemoryDetailsBinding binding = MemoryDetailsBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return MemoryDetailsMobilePortrait(
      viewModel: viewModel,
      initialIndex: widget.argument?.initialIndex ?? 0,
    );
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return MemoryDetailsMobileLandscape(
      viewModel: viewModel,
      initialIndex: widget.argument?.initialIndex ?? 0,
    );
  }
}
