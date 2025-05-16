class Issue{
  final int id;
  final String title;
  final String description;
  final String? issuePhotoUrl;
  final String createdBy;
  final DateTime createdAt;
  final int upvoteCount;
  final int downvoteCount;
  final int commentCount;
  final bool? isLiked;
  final bool? isDisliked;
  final String? voterId;

  Issue({
    required this.id,
    required this.title,
    required this.description,
    this.issuePhotoUrl,
    required this.createdBy,
    required this.createdAt,
    this.upvoteCount = 0,
    this.downvoteCount = 0,
    this.commentCount = 0,
    this.isLiked,
    this.isDisliked,
    this.voterId,
  });
}