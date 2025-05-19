import 'package:domain/model/user_response_data.dart';

abstract class ProfileRepository{
  Future<void> updateProfile(UserResponseData user);

  Future<void> updateProfilePhoto(String userId);
}