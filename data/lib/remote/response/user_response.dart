class UserDataResponse {
  final int id;
  final String name;
  final String email;
  final String photoUrl;
  final String fcmToken;
  final String role;
  final String userId;

  UserDataResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.fcmToken,
    required this.role,
    required this.userId,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) {
    return UserDataResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photo_url'],
      fcmToken: json['fcm_token'],
      role: json['role'],
      userId: json['user_id'],
    );
  }
}
