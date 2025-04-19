import 'package:data/local/shared_preference/entity/user_session_shared_pref_entity.dart';
import 'package:data/mapper/user_mapper.dart';
import 'package:data/service/google_sign_in_service.dart';
import 'package:domain/model/user_data.dart';
import 'package:domain/model/user_session.dart';
import 'package:domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final GoogleSignInService googleSignInService;

  AuthRepositoryImpl(this.googleSignInService);

  @override
  Future<UserSession> login({
    required String email,
    required String password,
  }) {
    //Dummy network call
    return Future.delayed(const Duration(seconds: 2), () {
      final user = UserSessionSharedPrefEntity(
        userId: '324234',
        accessToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
        refreshToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwicmVmcmVzaCI6eyJ1c2VybmFtZSI6ImFkbWluIiwicm9sZXMiOlsiUk9MRV9BRE1JTiJdfSwiaWF0IjoxNjM2MjUxMjIyLCJleHAiOjE2MzYyNTMwMjJ9.KG98H0x74oUukbP9g1tM5JylZL4j2WXjBL-N3s-cXoU',
        name: 'John Doe',
        email: email,
      );
      user.saveToSharedPref();
      return user.toUserSession();
    });
  }

  @override
  Future<bool> isLoggedIn() {
    return Future.delayed(const Duration(seconds: 2), () {
      return true;
    });
  }

  @override
  Future<bool> logout() {
    return Future.delayed(const Duration(seconds: 2), () {
      UserSessionSharedPrefEntity.example.deleteFromSharedPref();
      return true;
    });
  }

  @override
  Future<UserSession> register({
    required String email,
    required String password,
  }) {
    //Dummy network call
    return Future.delayed(const Duration(seconds: 2), () {
      final user = UserSessionSharedPrefEntity(
        userId: '324234',
        accessToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
        refreshToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwicmVmcmVzaCI6eyJ1c2VybmFtZSI6ImFkbWluIiwicm9sZXMiOlsiUk9MRV9BRE1JTiJdfSwiaWF0IjoxNjM2MjUxMjIyLCJleHAiOjE2MzYyNTMwMjJ9.KG98H0x74oUukbP9g1tM5JylZL4j2WXjBL-N3s-cXoU',
        name: 'John Doe',
        email: email,
      );
      return user.toUserSession();
    });
  }

  @override
  Future<UserSession> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 2));
    final UserSessionSharedPrefEntity userSessionSharedPref =
        (await UserSessionSharedPrefEntity.example.getFromSharedPref())
            as UserSessionSharedPrefEntity;
    return userSessionSharedPref.toUserSession();
  }

  @override
  Future<UserData> signInWithGoogle() {
    try {
      final user = googleSignInService.signIn();
      return user.then((value) => UserMapper.mapResponseToDomain(value));
    } catch (e) {
      rethrow;
    }
  }
}
