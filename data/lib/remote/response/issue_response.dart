class IssueResponse{
  final int id;
  final String title;
  final String description;
  final String createdBy;
  final DateTime createdAt;
  final int upvote;
  final int downvote;

  IssueResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.createdBy,
    required this.createdAt,
    required this.upvote,
    required this.downvote,
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
    );
  }
}