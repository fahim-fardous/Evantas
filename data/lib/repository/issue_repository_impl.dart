import 'package:data/mapper/answer_mapper.dart';
import 'package:data/mapper/issue_mapper.dart';
import 'package:data/service/supabase_service.dart';
import 'package:domain/model/answer.dart';
import 'package:domain/model/issue.dart';
import 'package:domain/repository/issue_repository.dart';

class IssueRepositoryImpl extends IssueRepository {
  final SupabaseService supabaseService;

  IssueRepositoryImpl({required this.supabaseService});

  @override
  Future<void> createIssue({required Issue issue}) async {
    try {
      await supabaseService.addIssue(issue);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Issue>> fetchIssues() async {
    try {
      final issues = await supabaseService.getIssues();
      return issues
          .map((issue) => IssueMapper.mapResponseToDomain(issue))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Issue?> fetchIssueById(int issueId) async {
    try {
      final issue = await supabaseService.getIssueById(issueId);
      if (issue == null) return null;
      return IssueMapper.mapResponseToDomain(issue);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Answer>> getAnswersByIssueId(int issueId) async {
    try {
      final answers = await supabaseService.getAnswersByIssueId(issueId);
      if (answers == null) return [];
      return answers
          .map((answer) => AnswerMapper.mapResponseToDomain(answer))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Answer>> getAllAnswers() {
    // TODO: implement getAllAnswers
    throw UnimplementedError();
  }

  @override
  Future<void> saveAnswer({required Answer answer}) async{
   try{
     await supabaseService.addAnswer(answer);
   }
   catch(e){
     rethrow;
   }
  }
}
