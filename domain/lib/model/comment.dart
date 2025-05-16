class Comment {
  final int id;
  final String comment;
  final String commentedBy;
  final DateTime commentedAt;
  bool isAccepted = false;
  final int issueId;

  Comment({
    required this.id,
    required this.comment,
    required this.commentedBy,
    required this.commentedAt,
    required this.isAccepted,
    required this.issueId,
  });
}
