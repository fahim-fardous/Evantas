import 'dart:io';

import 'package:data/service/supabase_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:domain/repository/memory_repository.dart';
import 'package:domain/util/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/memory_details/route/memory_details_argument.dart';
import 'package:evntas/presentation/localization/ui_text.dart';
import 'package:evntas/presentation/util/value_notifier_list.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
//import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class MemoryDetailsViewModel extends BaseViewModel<MemoryDetailsArgument> {
  final MemoryRepository memoryRepository;
  final SupabaseService supabaseService;

  final ValueNotifierList<String> _uploadedImages = ValueNotifierList([]);

  ValueNotifierList<String> get uploadedImages => _uploadedImages;

  final ValueNotifier<int?> _currentIndex = ValueNotifier(null);

  ValueListenable<int?> get currentIndex => _currentIndex;

  final ValueNotifier<int?> _initialIndex = ValueNotifier(null);

  ValueListenable<int?> get initialIndex => _initialIndex;

  MemoryDetailsViewModel({
    required this.memoryRepository,
    required this.supabaseService,
  });

  @override
  void onViewReady({MemoryDetailsArgument? argument}) {
    super.onViewReady();
    _initialIndex.value = argument!.initialIndex;
    _currentIndex.value = argument.initialIndex;
    fetchImages();
  }

  void onPageChanged(int index) {
    _currentIndex.value = index;
  }

  Future<void> fetchImages() async {
    final images = await loadData(memoryRepository.fetchImages());

    if (images.isNotEmpty) {
      final List<String> urls = images
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
        Permission permission = (await _getAndroidSdkVersion() >= 33)
            ? Permission.photos
            : Permission.storage;
        status = await permission.request();
      } else {
        status = PermissionStatus.granted;
      }

      downloadPhotoOnPermissionGranted(status, url);
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
      return (await DeviceInfoPlugin().androidInfo).version.sdkInt;
    }
    return 0;
  }
}
