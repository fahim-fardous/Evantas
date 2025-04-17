import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'profile',
  ]);

  Future<GoogleSignInAccount?> signIn() async {
    try{
      return await _googleSignIn.signIn();
    }catch(e){
      rethrow;
    }
  }

  Future<void> signOut() async {
    try{
      await _googleSignIn.signOut();
    }catch(e){
      rethrow;
    }
  }

  Future<bool> isSignedIn() async {
    try{
      return await _googleSignIn.isSignedIn();
    }catch(e){
      rethrow;
    }
  }

  Future<GoogleSignInAccount?> getCurrentUser() async {
    try{
      return _googleSignIn.currentUser;
    }catch(e){
      rethrow;
    }
  }
}
