import 'package:domain/model/google_user_data.dart';
import 'package:domain/model/user_response_data.dart';
import 'package:domain/model/user_session.dart';

abstract class AuthRepository {
  Future<UserSession> login({
    required String email,
    required String password,
  });

  Future<UserSession> register({
    required String email,
    required String password,
  });

  Future<UserSession> getCurrentUser();

  Future<bool> logout();

  Future<bool> isLoggedIn();

  Future<GoogleUserData> signInWithGoogle();

  Future<bool> isSignedIn();

  Future<void> signOut();

  Future<GoogleUserData> getUserData();

  Future<void> addUser(GoogleUserData user, String fcmToken);

  Future<UserResponseData?> getUserById(String id);
}
