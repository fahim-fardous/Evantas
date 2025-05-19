import 'package:domain/model/google_user_data.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleUserMapper{
  static GoogleUserData mapResponseToDomain(GoogleSignInAccount? googleUser) {
    return GoogleUserData(
      id: googleUser?.id ?? '',
      name: googleUser?.displayName ?? '',
      email: googleUser?.email ?? '',
      photoUrl: googleUser?.photoUrl ?? '',
    );
  }
}