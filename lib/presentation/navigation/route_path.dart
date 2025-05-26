import 'package:evntas/presentation/feature/points/route/points_argument.dart';
import 'package:evntas/presentation/feature/points/route/points_route.dart';
import 'package:evntas/presentation/feature/issue_details/route/issue_details_argument.dart';
import 'package:evntas/presentation/feature/issue_details/route/issue_details_route.dart';
import 'package:evntas/presentation/feature/add_issue/route/add_issue_argument.dart';
import 'package:evntas/presentation/feature/add_issue/route/add_issue_route.dart';
import 'package:evntas/presentation/feature/issue_list/route/issue_list_argument.dart';
import 'package:evntas/presentation/feature/issue_list/route/issue_list_route.dart';
import 'package:evntas/presentation/feature/edit_profile/route/edit_profile_argument.dart';
import 'package:evntas/presentation/feature/edit_profile/route/edit_profile_route.dart';
import 'package:evntas/presentation/feature/memory_details/route/memory_details_argument.dart';
import 'package:evntas/presentation/feature/memory_details/route/memory_details_route.dart';
import 'package:evntas/presentation/feature/profile/route/profile_argument.dart';
import 'package:evntas/presentation/feature/profile/route/profile_route.dart';
import 'package:evntas/presentation/feature/profile_picture/route/profile_picture_argument.dart';
import 'package:evntas/presentation/feature/profile_picture/route/profile_picture_route.dart';
import 'package:evntas/presentation/feature/user_onboarding/route/user_onboarding_argument.dart';
import 'package:evntas/presentation/feature/user_onboarding/route/user_onboarding_route.dart';
import 'package:evntas/presentation/feature/add_reminder/route/add_reminder_argument.dart';
import 'package:evntas/presentation/feature/add_reminder/route/add_reminder_route.dart';
import 'package:evntas/presentation/feature/memory/route/memory_argument.dart';
import 'package:evntas/presentation/feature/memory/route/memory_route.dart';
import 'package:evntas/presentation/feature/add_event/route/add_event_argument.dart';
import 'package:evntas/presentation/feature/add_event/route/add_event_route.dart';
import 'package:evntas/presentation/feature/profile/route/profile_argument.dart';
import 'package:evntas/presentation/feature/profile/route/profile_route.dart';
import 'package:evntas/presentation/feature/event_details/route/event_details_argument.dart';
import 'package:evntas/presentation/feature/event_details/route/event_details_route.dart';
import 'package:evntas/presentation/feature/event_list/route/event_list_argument.dart';
import 'package:evntas/presentation/feature/event_list/route/event_list_route.dart';
import 'package:evntas/presentation/feature/splash/route/splash_argument.dart';
import 'package:evntas/presentation/feature/splash/route/splash_route.dart';
import 'package:evntas/presentation/base/base_argument.dart';
import 'package:evntas/presentation/base/base_route.dart';
import 'package:evntas/presentation/feature/auth/login/route/login_argument.dart';
import 'package:evntas/presentation/feature/auth/login/route/login_route.dart';
import 'package:evntas/presentation/feature/home/movie_list/route/movie_list_argument.dart';
import 'package:evntas/presentation/feature/home/movie_list/route/movie_list_route.dart';
import 'package:evntas/presentation/feature/home/route/home_argument.dart';
import 'package:evntas/presentation/feature/home/route/home_route.dart';
import 'package:evntas/presentation/feature/movieDetails/route/movie_details_argument.dart';
import 'package:evntas/presentation/feature/movieDetails/route/movie_details_route.dart';
import 'package:evntas/presentation/feature/settings/route/settings_argument.dart';
import 'package:evntas/presentation/feature/settings/route/settings_route.dart';
import 'package:evntas/presentation/navigation/unknown_page_route.dart';

enum RoutePath {
  login,
  home,
  movieList,
  movieSearch,
  movieBookmark,
  setting,
  movieDetails,
  splash,
  eventList,
  eventDetails,
  profile,
  addEvent,
  memory,
  createReminder,
  userOnboarding,
  memoryDetails,
  editProfile,
  profilePicture,
  issueList,
  addIssue,
  issueDetails,
  points, 
  unknown;

  static RoutePath fromString(String? path) {
    switch (path) {
      case '/login':
        return RoutePath.login;
      case '/home':
        return RoutePath.home;
      case '/movieList':
        return RoutePath.movieList;
      case '/movieSearch':
        return RoutePath.movieSearch;
      case '/movieBookmark':
        return RoutePath.movieBookmark;
      case '/setting':
        return RoutePath.setting;
      case '/movieDetails':
        return RoutePath.movieDetails;
      case '/splash':
        return RoutePath.splash;
      case '/eventList':
        return RoutePath.eventList;
      case '/eventDetails':
        return RoutePath.eventDetails;
      case '/profile':
        return RoutePath.profile;
      case '/addEvent':
        return RoutePath.addEvent;
      case '/memory':
        return RoutePath.memory;
      case '/createReminder':
        return RoutePath.createReminder;
      case '/userOnboarding':
        return RoutePath.userOnboarding;
      case '/memoryDetails':
        return RoutePath.memoryDetails;
      case '/profile':
        return RoutePath.profile;
      case '/editProfile':
        return RoutePath.editProfile;
      case '/profilePicture':
        return RoutePath.profilePicture;
      case '/issueList':
        return RoutePath.issueList;
      case '/addIssue':
        return RoutePath.addIssue;
      case '/issueDetails':
        return RoutePath.issueDetails;
      case '/points':
        return RoutePath.points;
      default:
        return RoutePath.unknown;
    }
  }

  String get toPathString {
    switch (this) {
      case RoutePath.login:
        return '/login';
      case RoutePath.home:
        return '/home';
      case RoutePath.movieList:
        return '/movieList';
      case RoutePath.movieSearch:
        return '/movieSearch';
      case RoutePath.movieBookmark:
        return '/movieBookmark';
      case RoutePath.setting:
        return '/setting';
      case RoutePath.movieDetails:
        return '/movieDetails';
      case RoutePath.splash:
        return '/splash';
      case RoutePath.eventList:
        return '/eventList';
      case RoutePath.eventDetails:
        return '/eventDetails';
      case RoutePath.profile:
        return '/profile';
      case RoutePath.addEvent:
        return '/addEvent';
      case RoutePath.memory:
        return '/memory';
      case RoutePath.createReminder:
        return '/createReminder';
      case RoutePath.userOnboarding:
        return '/userOnboarding';
      case RoutePath.memoryDetails:
        return '/memoryDetails';
      case RoutePath.editProfile:
        return '/editProfile';
      case RoutePath.profilePicture:
        return '/profilePicture';
      case RoutePath.issueList:
        return '/issueList';
      case RoutePath.addIssue:
        return '/addIssue';
      case RoutePath.issueDetails:
        return '/issueDetails';
      case RoutePath.points:
        return '/points';
      default:
        return '';
    }
  }

  BaseRoute getAppRoute({BaseArgument? arguments}) {
    switch (this) {
      case RoutePath.login:
        return LoginRoute(
          arguments: arguments as LoginArgument?,
        );
      case RoutePath.home:
        if (arguments is! HomeArgument) {
          throw Exception('HomeArgument is required');
        }
        return HomeRoute(arguments: arguments);
      case RoutePath.movieList:
        if (arguments is! MovieListArgument) {
          throw Exception('MovieListArgument is required');
        }
        return MovieListRoute(arguments: arguments);
      case RoutePath.movieDetails:
        if (arguments is! MovieDetailsArgument) {
          throw Exception('MovieDetailsArgument is required');
        }
        return MovieDetailsRoute(arguments: arguments);
      case RoutePath.setting:
        if (arguments is! SettingsArgument) {
          throw Exception('SettingsArgument is required');
        }
        return SettingsRoute(arguments: arguments);
      case RoutePath.splash:
        if (arguments is! SplashArgument) {
          throw Exception('SplashArgument is required');
        }
        return SplashRoute(arguments: arguments);
      case RoutePath.eventList:
        if (arguments is! EventListArgument) {
          throw Exception('EventListArgument is required');
        }
        return EventListRoute(arguments: arguments);
      case RoutePath.eventDetails:
        if (arguments is! EventDetailsArgument) {
          throw Exception('EventDetailsArgument is required');
        }
        return EventDetailsRoute(arguments: arguments);
      case RoutePath.profile:
        if (arguments is! ProfileArgument) {
          throw Exception('ProfileArgument is required');
        }
        return ProfileRoute(arguments: arguments);
      case RoutePath.addEvent:
        if (arguments is! AddEventArgument) {
          throw Exception('AddEventArgument is required');
        }
        return AddEventRoute(arguments: arguments);
      case RoutePath.memory:
        if (arguments is! MemoryArgument) {
          throw Exception('MemoryArgument is required');
        }
        return MemoryRoute(arguments: arguments);
      case RoutePath.createReminder:
        if (arguments is! AddReminderArgument) {
          throw Exception('AddReminderArgument is required');
        }
        return AddReminderRoute(arguments: arguments);
      case RoutePath.userOnboarding:
        if (arguments is! UserOnboardingArgument) {
          throw Exception('UserOnboardingArgument is required');
        }
        return UserOnboardingRoute(arguments: arguments);
      case RoutePath.memoryDetails:
        if (arguments is! MemoryDetailsArgument) {
          throw Exception('MemoryDetailsArgument is required');
        }
        return MemoryDetailsRoute(arguments: arguments);
      case RoutePath.editProfile:
        if (arguments is! EditProfileArgument) {
          throw Exception('EditProfileArgument is required');
        }
        return EditProfileRoute(arguments: arguments);
      case RoutePath.profilePicture:
        if (arguments is! ProfilePictureArgument) {
          throw Exception('ProfilePictureArgument is required');
        }
        return ProfilePictureRoute(arguments: arguments);
      case RoutePath.issueList:
        if (arguments is! IssueListArgument) {
          throw Exception('IssueListArgument is required');
        }
        return IssueListRoute(arguments: arguments);
      case RoutePath.addIssue:
        if (arguments is! AddIssueArgument) {
          throw Exception('AddIssueArgument is required');
        }
        return AddIssueRoute(arguments: arguments);
      case RoutePath.issueDetails:
        if (arguments is! IssueDetailsArgument) {
          throw Exception('IssueDetailsArgument is required');
        }
        return IssueDetailsRoute(arguments: arguments);
      case RoutePath.points:
        if (arguments is! PointsArgument) {
          throw Exception('PointsArgument is required');
        }
        return PointsRoute(arguments: arguments);
      default:
        return UnknownRoute(arguments: arguments);
    }
  }
}
