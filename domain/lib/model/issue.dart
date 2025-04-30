class Issue{
  final int id;
  final String title;
  final String description;
  final String? issuePhotoUrl;
  final String createdBy;
  final DateTime createdAt;
  final int upvoteCount;
  final int downvoteCount;

  Issue({
    required this.id,
    required this.title,
    required this.description,
    this.issuePhotoUrl,
    required this.createdBy,
    required this.createdAt,
    this.upvoteCount = 0,
    this.downvoteCount = 0,
  });
}