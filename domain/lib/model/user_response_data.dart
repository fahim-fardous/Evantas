class UserResponseData {
  final int id;
  final String name;
  final String email;
  final String photoUrl;
  final String fcmToken;
  final String role;
  final String userId;

  UserResponseData({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.fcmToken,
    required this.role,
    required this.userId,
  });
}
