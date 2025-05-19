import 'package:data/remote/response/comment_response.dart';
import 'package:domain/model/comment.dart';

class CommentMapper {
  static Comment mapResponseToDomain(CommentResponse response) {
    return Comment(
        id: response.id,
        comment: response.comment,
        commentedBy: response.createdBy,
        commentedAt: response.createdAt,
        isAccepted: response.isAccepted,
        issueId: response.issueId);
  }
}
