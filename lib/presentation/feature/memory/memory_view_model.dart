import 'dart:io';

import 'package:data/service/supabase_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:domain/repository/memory_repository.dart';
import 'package:domain/util/logger.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/memory/route/memory_argument.dart';
import 'package:evntas/presentation/feature/memory_details/route/memory_details_argument.dart';
import 'package:evntas/presentation/feature/memory_details/route/memory_details_route.dart';
import 'package:evntas/presentation/localization/ui_text.dart';
import 'package:evntas/presentation/util/value_notifier_list.dart';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MemoryViewModel extends BaseViewModel<MemoryArgument> {
  final SupabaseService supabaseService;
  final MemoryRepository memoryRepository;

  final ValueNotifierList<String> _uploadedImages = ValueNotifierList([]);

  ValueNotifierList<String> get uploadedImages => _uploadedImages;

  MemoryViewModel({
    required this.supabaseService,
    required this.memoryRepository,
  });

  @override
  void onViewReady({MemoryArgument? argument}) {
    super.onViewReady(argument: argument);
    _fetchImages();
  }

  Future<void> uploadPhoto(ImageSource source) async {
    await loadData(memoryRepository.uploadPhoto(source));
    _fetchImages();
  }

  Future<void> deletePhoto(String pathName) async {
    String fileName = pathName.split('/').last;
    await loadData(memoryRepository.deletePhoto(fileName));
    _fetchImages();
  }

  Future<void> _fetchImages() async {
      final response =
          await loadData(memoryRepository.fetchImages());

      if (response.isEmpty) return;

      if (response.isNotEmpty) {
        final List<String> urls = response
            .where((file) => file.name != '.emptyFolderPlaceholder')
            .map((file) {
          return supabaseService.supabaseClient.storage
              .from('photos')
              .getPublicUrl(file.name);
        }).toList();

        _uploadedImages.value = urls;
      }
  }

  Future<void> downloadPhoto(String url) async {
    try {
      PermissionStatus status;

      if (Platform.isAndroid) {
        // Android-specific permission logic
        Permission permission = (await _getAndroidSdkVersion() >= 33)
            ? Permission.photos
            : Permission.storage;
        status = await permission.request();
      } else {
        // iOS: No preemptive permission request needed; Photos prompt happens on save
        status = PermissionStatus.granted;
      }

      //downloadPhotoOnPermissionGranted(status, url);
    } catch (e) {
      Logger.error("Error downloading file: $e");
      showToast(uiText: FixedUiText(text: "Failed to download image"));
    }
  }

  Future<void> downloadPhotoOnPermissionGranted(PermissionStatus status, String url) async {
    if (status.isGranted) {
      final response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
      final Uint8List bytes = Uint8List.fromList(response.data);
      final result = await ImageGallerySaverPlus.saveImage(bytes);
      if (result['isSuccess'] == true) {
        showToast(uiText: FixedUiText(text: "Image saved to gallery"));
      } else {
        throw Exception("Failed to save image: ${result['errorMessage']}");
      }
    } else if (status.isDenied) {
      showToast(uiText: FixedUiText(text: Platform.isAndroid
          ? "Please grant storage permission"
          : "Please allow access to Photos"));
    } else if (status.isPermanentlyDenied) {
      showToast(uiText: FixedUiText(text: "Permission denied. Please enable it in settings."));
      await openAppSettings();
    }
  }

  Future<int> _getAndroidSdkVersion() async {
    if (Platform.isAndroid) {
      return (await DeviceInfoPlugin().androidInfo).version.sdkInt ?? 0;
    }
    return 0;
  }

  void onTapPhoto(int index) {
    navigateToScreen(
      onPop: _fetchImages,
      destination: MemoryDetailsRoute(
        arguments: MemoryDetailsArgument(
          initialIndex: index,
        ),
      ),
    );
  }
}
