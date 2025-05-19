import 'package:domain/model/answer.dart';

class AnswerMapper {
  static Answer mapResponseToDomain(dynamic response) {
    return Answer(
      id: response['id'],
      answer: response['answer'],
      answeredBy: response['answered_by'],
      answeredAt: response['answered_at'],
      votes: response['votes'],
      isAnswerAccepted: response['is_answer_accepted'],
      issueId: response['issue_id'],
    );
  }
}
