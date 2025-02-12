import 'package:flutter/material.dart';
import 'package:evntas/presentation/feature/image_viewer/screen/image_viewer_mobile_portrait.dart';

class ImageViewerMobileLandscape extends ImageViewerMobilePortrait {
  const ImageViewerMobileLandscape({required super.initialPage,required super.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => ImageViewerMobileLandscapeState();
}

class ImageViewerMobileLandscapeState extends ImageViewerMobilePortraitState {}
