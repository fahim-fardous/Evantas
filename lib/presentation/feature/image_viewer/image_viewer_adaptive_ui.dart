import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_adaptive_ui.dart';
import 'package:evntas/presentation/feature/image_viewer/binding/image_viewer_binding.dart';
import 'package:evntas/presentation/feature/image_viewer/route/image_viewer_argument.dart';
import 'package:evntas/presentation/feature/image_viewer/image_viewer_view_model.dart';
import 'package:evntas/presentation/feature/image_viewer/route/image_viewer_route.dart';
import 'package:evntas/presentation/feature/image_viewer/screen/image_viewer_mobile_portrait.dart';
import 'package:evntas/presentation/feature/image_viewer/screen/image_viewer_mobile_landscape.dart';

class ImageViewerAdaptiveUi extends BaseAdaptiveUi<ImageViewerArgument, ImageViewerRoute> {
  const ImageViewerAdaptiveUi({super.argument, super.key});

  @override
  State<StatefulWidget> createState() => ImageViewerAdaptiveUiState();
}

class ImageViewerAdaptiveUiState extends BaseAdaptiveUiState<ImageViewerArgument, ImageViewerRoute, ImageViewerAdaptiveUi, ImageViewerViewModel, ImageViewerBinding> {
  @override
  ImageViewerBinding binding = ImageViewerBinding();

  @override
  StatefulWidget mobilePortraitContents(BuildContext context) {
    return ImageViewerMobilePortrait(viewModel: viewModel, initialPage: widget.argument!.initialPage,);
  }

  @override
  StatefulWidget mobileLandscapeContents(BuildContext context) {
    return ImageViewerMobileLandscape(viewModel: viewModel, initialPage: widget.argument!.initialPage,);
  }
}
