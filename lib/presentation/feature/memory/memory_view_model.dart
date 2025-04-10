import 'dart:io';
import 'package:data/service/supabase_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hello_flutter/presentation/base/base_viewmodel.dart';
import 'package:hello_flutter/presentation/feature/memory/route/memory_argument.dart';
import 'package:hello_flutter/presentation/localization/ui_text.dart';
import 'package:hello_flutter/presentation/util/value_notifier_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MemoryViewModel extends BaseViewModel<MemoryArgument> {
  final SupabaseService supabaseService;

  final ValueNotifierList<String> _uploadedImages = ValueNotifierList([]);

  ValueNotifierList<String> get uploadedImages => _uploadedImages;

  MemoryViewModel({required this.supabaseService});

  @override
  void onViewReady({MemoryArgument? argument}) {
    super.onViewReady(argument: argument);
    _fetchImages();
  }

  Future<void> uploadPhoto(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        final File file = File(image.path);
        final String fileName = "${DateTime.now().microsecondsSinceEpoch}.jpg";

        await supabaseService.supabaseClient.storage.from('photos').upload(
              fileName,
              file,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: false,
              ),
            );

        final String publicUrl = supabaseService.supabaseClient.storage
            .from('photos')
            .getPublicUrl(fileName);

        _uploadedImages.value = [..._uploadedImages.value, publicUrl];
      }
    } catch (e) {
      showToast(uiText: FixedUiText(text: e.toString()));
    }
  }

  Future<void> _fetchImages() async {
    try {
      final response =
      await supabaseService.supabaseClient.storage.from('photos').list();

      if (response.isEmpty) return;

      if (response.isNotEmpty) {
        final List<String> urls = response
            .where((file) => file.name != '.emptyFolderPlaceholder') // Filter out the placeholder
            .map((file) {
          return supabaseService.supabaseClient.storage
              .from('photos')
              .getPublicUrl(file.name);
        }).toList();

        _uploadedImages.value = urls;
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print("Error fetching images: $e");
    } catch (e) {
      showToast(uiText: FixedUiText(text: e.toString()));
    }
  }

  void pickImage() {
    // Assuming you want to show a dialog like in the previous example
    // This would typically be handled in the UI layer, but including here for completeness
    // You might want to move this to your widget instead
  }

  void onBackButtonPressed() {
    navigateBack();
  }

  @override
  void dispose() {
    _uploadedImages.dispose();
    super.onDispose();
  }
}
