class AnswerResponse {
  final int id;
  final String answer;
  final String answeredBy;
  final DateTime answeredAt;
  final int votes;
  final bool isAnswerAccepted;
  final String issueId;

  AnswerResponse({
    required this.id,
    required this.answer,
    required this.answeredBy,
    required this.answeredAt,
    required this.votes,
    required this.isAnswerAccepted,
    required this.issueId,
  });

  factory AnswerResponse.fromJson(Map<String, dynamic> json) {
    return AnswerResponse(
      id: json['id'],
      answer: json['answer'],
      answeredBy: json['answered_by'],
      answeredAt: DateTime.parse(json['answered_at']),
      votes: json['votes'],
      isAnswerAccepted: json['is_answer_accepted'],
      issueId: json['issue_id'],
    );
  }
}
