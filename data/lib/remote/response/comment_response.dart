class CommentResponse {
  final int id;
  final String comment;
  final String createdBy;
  final DateTime createdAt;
  final bool isAccepted;
  final int issueId;

  CommentResponse({
    required this.id,
    required this.comment,
    required this.createdBy,
    required this.createdAt,
    required this.isAccepted,
    required this.issueId,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      id: json['id'],
      comment: json['answer'],
      createdBy: json['answered_by'],
      createdAt: DateTime.parse(json['answered_at']),
      isAccepted: json['is_answer_accepted'],
      issueId: json['issue_id'],
    );
  }
}
