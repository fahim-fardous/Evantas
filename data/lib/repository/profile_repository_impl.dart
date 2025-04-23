import 'dart:io';

import 'package:data/local/shared_preference/shared_pref_manager.dart';
import 'package:data/service/supabase_service.dart';
import 'package:domain/model/user_response_data.dart';
import 'package:domain/repository/profile_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final SupabaseService supabaseService;

  ProfileRepositoryImpl({
    required this.supabaseService,
  });

  @override
  Future<void> updateProfile(UserResponseData user) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfilePhoto(String userId) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final File file = File(image.path);
        final String fileName = "${DateTime.now().microsecondsSinceEpoch}.jpg";

        await supabaseService.supabaseClient.storage
            .from('profile-picture')
            .upload(
              fileName,
              file,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: false,
              ),
            );

        await supabaseService.supabaseClient.from('users').update({
          'photo_url': supabaseService.supabaseClient.storage
              .from('profile-picture')
              .getPublicUrl(fileName)
        }).eq('user_id', userId);
      }
    } catch (e) {
      rethrow;
    }
  }
}
