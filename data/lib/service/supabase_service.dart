import 'package:data/mapper/google_user_mapper.dart';
import 'package:data/remote/response/answer_response.dart';
import 'package:data/remote/response/comment_response.dart';
import 'package:data/remote/response/event_response.dart';
import 'package:data/remote/response/issue_response.dart';
import 'package:data/remote/response/user_response.dart';
import 'package:domain/model/answer.dart';
import 'package:domain/model/comment.dart';
import 'package:domain/model/event.dart';
import 'package:domain/model/google_user_data.dart';
import 'package:domain/model/issue.dart';
import 'package:domain/util/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabaseClient;

  SupabaseService({required this.supabaseClient});

  Future<void> addEvent(Event event) async {
    await supabaseClient.from('events').insert({
      'title': event.title,
      'description': event.description,
      'date': event.date.toIso8601String().split('T')[0],
      'location': event.location,
      'event_type': event.eventType.name,
      'time': "${event.time.hour}:${event.time.minute}",
    });
  }

  Future<List<EventResponse>> getEvents() async {
    final response = await supabaseClient.from('events').select();
    return response.map((event) {
      return EventResponse.fromJson(event);
    }).toList();
  }

  Future<EventResponse?> getEventById(int id) async {
    final response =
        await supabaseClient.from('events').select().eq('id', id).single();
    return EventResponse.fromJson(response);
  }

  Future<void> addUser(GoogleUserData user) async {
    await supabaseClient.from('users').insert({
      'name': user.name,
      'email': user.email,
      'photo_url': user.photoUrl,
      'fcm_token': user.id,
      'role': 'admin',
      'user_id': user.id
    });
  }

  Future<UserDataResponse?> getUserById(String userId) async {
    try {
      final isUserExists = await supabaseClient
          .from('users')
          .select()
          .eq('user_id', userId)
          .limit(1)
          .maybeSingle();

      if (isUserExists == null) {
        return null;
      }

      final response = await supabaseClient
          .from('users')
          .select()
          .eq('user_id', userId)
          .single();
      return UserDataResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<void> addIssue(Issue issue) async {
    try {
      await supabaseClient.from('issues').insert({
        'title': issue.title,
        'description': issue.description,
        'created_by': issue.createdBy,
        'created_at': issue.createdAt.toIso8601String(),
        'upvote': issue.upvoteCount,
        'downvote': issue.downvoteCount
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<IssueResponse>> getIssues(String userId) async {
    final issues = await supabaseClient
        .from('issues_with_user_vote')
        .select('*')
        .order('created_at', ascending: false);

    final seen = <int>{};
    final result = <IssueResponse>[];

    for (var row in issues) {
      final issue = IssueResponse.fromJson(row);
      if (!seen.contains(issue.id)) {
        result.add(issue);
        seen.add(issue.id);
      }
    }

    return result;
  }

  Future<IssueResponse?> getIssueById(int id) async {
    try {
      final response = await supabaseClient
          .from('issues')
          .select()
          .eq('id', id)
          .maybeSingle();
      if (response == null) {
        return null;
      }
      return IssueResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<void> likeIssue(Issue issue, String userId) async {
    try {
      final existingVote = await supabaseClient
          .from('issue_votes')
          .select()
          .eq('issue_id', issue.id)
          .eq('user_id', userId)
          .maybeSingle();

      final wasLiked = existingVote?['is_liked'] ?? false;
      final wasDisliked = existingVote?['is_disliked'] ?? false;

      if (wasLiked) return;

      if (existingVote == null) {
        await supabaseClient.from('issue_votes').insert({
          'issue_id': issue.id,
          'user_id': userId,
          'is_liked': true,
          'is_disliked': false,
        });
        await supabaseClient
            .from('issues')
            .update({'upvote': issue.upvoteCount + 1}).eq('id', issue.id);
      } else {
        await supabaseClient.from('issue_votes').update({
          'is_liked': true,
          'is_disliked': false,
        }).eq('id', existingVote['id']);

        await supabaseClient.from('issues').update({
          'upvote': issue.upvoteCount + 1,
          'downvote':
              wasDisliked ? issue.downvoteCount - 1 : issue.downvoteCount
        }).eq('id', issue.id);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> dislikeIssue(Issue issue, String userId) async {
    try {
      final existingVote = await supabaseClient
          .from('issue_votes')
          .select()
          .eq('issue_id', issue.id)
          .eq('user_id', userId)
          .maybeSingle();

      final wasLiked = existingVote?['is_liked'] ?? false;
      final wasDisliked = existingVote?['is_disliked'] ?? false;

      if (wasDisliked) return;

      if (existingVote == null) {
        await supabaseClient.from('issue_votes').insert({
          'issue_id': issue.id,
          'user_id': userId,
          'is_liked': false,
          'is_disliked': true,
        });
        await supabaseClient
            .from('issues')
            .update({'downvote': issue.downvoteCount + 1}).eq('id', issue.id);
      } else {
        await supabaseClient.from('issue_votes').update({
          'is_liked': false,
          'is_disliked': true,
        }).eq('id', existingVote['id']);

        await supabaseClient.from('issues').update({
          'downvote': issue.downvoteCount + 1,
          'upvote': wasLiked ? issue.upvoteCount - 1 : issue.upvoteCount
        }).eq('id', issue.id);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addAnswer(Answer answer) async {
    try {
      await supabaseClient.from('answers').insert({
        'answer': answer.answer,
        'answered_by': answer.answeredBy,
        'answered_at': answer.answeredAt.toIso8601String(),
        'votes': answer.votes,
        'is_answer_accepted': answer.isAnswerAccepted,
        'issue_id': answer.issueId,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AnswerResponse>?> getAnswersByIssueId(int id) async {
    try {
      List<dynamic> response =
          await supabaseClient.from('answers').select().eq('issue_id', id);

      if (response.isEmpty) {
        return null;
      }
      return response.map((answer) {
        return AnswerResponse.fromJson(answer);
      }).toList();
    } catch (e) {
      return null;
    }
  }

  Future<List<IssueResponse>> getIssueVotesByCurrentUser(String userId) async {
    try {
      final response = await supabaseClient
          .from('issues_with_user_vote')
          .select()
          .eq('user_id', userId);

      return response.map((issue) {
        return IssueResponse.fromJson(issue);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<IssueResponse?> getIssueVoteById(int issueId, String userId) async {
    try {
      final response = await supabaseClient
          .from('issues_with_user_vote')
          .select()
          .eq('issue_id', issueId)
          .eq('user_id', userId)
          .maybeSingle();
      if(response == null){
        return null;
      }
      return IssueResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addComment(Comment comment) async {
    try {
      await supabaseClient.from('answers').insert({
        'answer': comment.comment,
        'answered_by': comment.commentedBy,
        'answered_at': comment.commentedAt.toIso8601String(),
        'is_answer_accepted': comment.isAccepted,
        'issue_id': comment.issueId,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CommentResponse>> getCommentsByIssueId(int id) async {
    try {
      final response = await supabaseClient
          .from('answers')
          .select()
          .eq('issue_id', id)
          .order('answered_at', ascending: true);

      return response.map((comment) {
        return CommentResponse.fromJson(comment);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePhoto(String fileName) async {
    await supabaseClient.storage.from('photos').remove([fileName]);
  }
}
