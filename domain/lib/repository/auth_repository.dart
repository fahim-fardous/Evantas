import 'package:domain/model/user_session.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<GoogleSignInAccount?> signInWithGoogle();
}
