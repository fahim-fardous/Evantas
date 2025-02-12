import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/navigation/route_path.dart';
import 'package:evntas/presentation/feature/image_viewer/image_viewer_adaptive_ui.dart';
import 'package:evntas/presentation/feature/image_viewer/route/image_viewer_argument.dart';

class ImageViewerRoute extends BaseRoute<ImageViewerArgument> {
  @override
  RoutePath routePath = RoutePath.imageViewer;

  ImageViewerRoute({required super.arguments});

  @override
  MaterialPageRoute toMaterialPageRoute() {
    return MaterialPageRoute(
      builder: (_) => ImageViewerAdaptiveUi(
        argument: arguments,
      ),
    );
  }
}
