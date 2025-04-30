class Answer {
  final int id;
  final String answer;
  final String answeredBy;
  final DateTime answeredAt;
  final int votes;
  final bool isAnswerAccepted;
  final int issueId;

  Answer({
    required this.id,
    required this.answer,
    required this.answeredBy,
    required this.answeredAt,
    required this.votes,
    required this.isAnswerAccepted,
    required this.issueId,
  });
}
