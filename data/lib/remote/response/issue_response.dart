class IssueResponse {
  final int id;
  final String title;
  final String description;
  final String createdBy;
  final DateTime createdAt;
  final int upvote;
  final int downvote;
  final int? commentCount;
  final bool? isLiked;
  final bool? isDisliked;

  IssueResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.createdBy,
    required this.createdAt,
    required this.upvote,
    required this.downvote,
    required this.commentCount,
    this.isLiked,
    this.isDisliked,
  });

  factory IssueResponse.fromJson(Map<String, dynamic> json) {
    return IssueResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['created_at']),
      upvote: json['upvote'],
      downvote: json['downvote'],
      commentCount: json['comment_count'] ?? 0,
      isLiked: json['is_liked'] ?? false,
      isDisliked: json['is_disliked'] ?? false,
    );
  }
}
