import 'package:evntas/presentation/base/base_argument.dart';

class IssueDetailsArgument extends BaseArgument {
  int issueId;
  String userId;

  IssueDetailsArgument({
    required this.issueId,
    required this.userId,
  });
}
