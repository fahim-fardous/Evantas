class IssueVote {
  int id;
  int issueId;
  String userId;
  bool isLiked;
  bool isDisliked;

  IssueVote({
    required this.id,
    required this.issueId,
    required this.userId,
    required this.isLiked,
    required this.isDisliked,
  });
}
