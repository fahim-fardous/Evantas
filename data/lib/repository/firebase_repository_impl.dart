import 'package:data/service/notification_service.dart';
import 'package:domain/repository/firebase_repository.dart';
import 'package:domain/util/logger.dart';

class FirebaseRepositoryImpl extends FirebaseRepository{
  final FirebaseNotificationService firebaseService;
  FirebaseRepositoryImpl({required this.firebaseService});

  @override
  Future<String?> getFCMToken() async{
    String? receivedToken;
    await firebaseService.setupFCMToken(onTokenRefresh: (token){
      Logger.debug("FCM token: $token");
      receivedToken = token;
    });

    return receivedToken;
  }

}