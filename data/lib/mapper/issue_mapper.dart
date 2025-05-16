import 'package:data/remote/response/issue_response.dart';
import 'package:domain/model/issue.dart';

class IssueMapper {
  static Issue mapResponseToDomain(IssueResponse response) {
    return Issue(
      id: response.id,
      title: response.title,
      description: response.description,
      createdBy: response.createdBy,
      createdAt: response.createdAt,
      upvoteCount: response.upvote,
      downvoteCount: response.downvote,
      isLiked: response.isLiked,
      isDisliked: response.isDisliked,
    );
  }
}
