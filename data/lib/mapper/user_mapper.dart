import 'package:domain/model/user_data.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserMapper{
  static UserData mapResponseToDomain(GoogleSignInAccount? googleUser) {
    return UserData(
      id: googleUser?.id ?? '',
      name: googleUser?.displayName ?? '',
      email: googleUser?.email ?? '',
      photoUrl: googleUser?.photoUrl ?? '',
    );
  }
}