import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  // Singleton instance
  static final GoogleSignInService _instance = GoogleSignInService._internal();

  // Factory constructor to return the singleton instance
  factory GoogleSignInService() {
    return _instance;
  }

  // Private constructor for singleton
  GoogleSignInService._internal();

  // Google Sign-In plugin instance
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // You can specify required scopes here
    scopes: [
      'email',
      'profile',
    ],
  );

  // Check if user is signed in
  Future<bool> get isSignedIn async => await _googleSignIn.isSignedIn();

  // Get current user
  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  // Sign in with Google
  Future<GoogleSignInAccount?> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      return googleUser;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Get authentication data (useful for backend verification)
  Future<Map<String, String?>> getAuthData() async {
    try {
      final GoogleSignInAccount? googleUser = _googleSignIn.currentUser;

      if (googleUser == null) {
        throw Exception('No user signed in');
      }

      // Get auth response
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      return {
        'accessToken': googleAuth.accessToken,
        'idToken': googleAuth.idToken,
      };
    } catch (e) {
      rethrow;
    }
  }

  // Get user info
  Map<String, String?> getUserInfo() {
    final user = _googleSignIn.currentUser;
    if (user != null) {
      return {
        'id': user.id,
        'displayName': user.displayName,
        'email': user.email,
        'photoUrl': user.photoUrl,
      };
    }
    return {};
  }
}