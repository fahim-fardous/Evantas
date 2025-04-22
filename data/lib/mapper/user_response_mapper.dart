import 'package:data/remote/response/user_response.dart';
import 'package:domain/model/user_response_data.dart';

class UserResponseMapper {
  static UserResponseData mapResponseToDomain(UserDataResponse response) {
    return UserResponseData(
      id: response.id,
      name: response.name,
      email: response.email,
      photoUrl: response.photoUrl,
      fcmToken: response.fcmToken,
      role: response.role,
      userId: response.userId,
    );
  }
}
