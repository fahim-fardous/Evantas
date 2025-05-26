import 'package:data/local/shared_preference/shared_pref_manager.dart';
import 'package:data/remote/api_client/api_client.dart';
import 'package:data/remote/api_client/movie_api_client.dart';
import 'package:data/remote/api_service/movie_api_service.dart';
import 'package:data/remote/api_service/movie_api_service_impl.dart';
import 'package:data/repository/auth_repository_impl.dart';
import 'package:data/repository/event_repository_impl.dart';
import 'package:data/repository/firebase_repository_impl.dart';
import 'package:data/repository/issue_repository_impl.dart';
import 'package:data/repository/location_repository_impl.dart';
import 'package:data/repository/memory_repository_impl.dart';
import 'package:data/repository/movie_repository_impl.dart';
import 'package:data/repository/profile_repository_impl.dart';
import 'package:data/service/google_sign_in_service.dart';
import 'package:data/service/notification_service.dart';
import 'package:data/service/supabase_service.dart';
import 'package:domain/di/di_module.dart';
import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/event_repository.dart';
import 'package:domain/repository/firebase_repository.dart';
import 'package:domain/repository/issue_repository.dart';
import 'package:domain/repository/location_repository.dart';
import 'package:domain/repository/memory_repository.dart';
import 'package:domain/repository/movie_repository.dart';
import 'package:domain/repository/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataModule {
  DataModule._internal();

  static final DataModule _instance = DataModule._internal();

  factory DataModule() => _instance;

  final DiModule _diModule = DiModule();

  Future<void> injectDependencies() async {
    await injectApiClient();
    await injectApiService();
    await injectGoogleSignInService();
    await injectLocalDataService();
    await injectFirebaseService();
    await injectSupabaseService();
    await injectRepositories();
  }

  Future<void> removeDependencies() async {
    await removeRepositories();
    await removeSupabaseService();
    await removeFirebaseService();
    await removeLocalDataService();
    await removeGoogleSignInService();
    await removeApiService();
    await removeApiClient();
  }

  Future<void> injectSupabaseService() async {
    final supabaseClient = Supabase.instance.client;
    final appRepository = await _diModule.resolve<AppRepository>();
    await _diModule.registerSingleton<SupabaseService>(SupabaseService(
      supabaseClient: supabaseClient,
      appRepository: appRepository,
    ));
  }

  Future<void> removeSupabaseService() async {
    await _diModule.unregisterSingleton<SupabaseService>();
  }

  Future<void> injectFirebaseService() async {
    final appRepository = await _diModule.resolve<AppRepository>();
    await _diModule.registerSingleton<FirebaseNotificationService>(
        FirebaseNotificationService());
    await FirebaseNotificationService.initialize();
  }

  Future<void> removeFirebaseService() async {
    await _diModule.unregisterSingleton<FirebaseNotificationService>();
  }

  Future<void> injectApiClient() async {
    await _diModule.registerSingleton<ApiClient>(MovieApiClient());
  }

  Future<void> removeApiClient() async {
    await _diModule.unregisterSingleton<ApiClient>();
  }

  Future<void> injectApiService() async {
    final apiClient = await _diModule.resolve<ApiClient>();
    await _diModule.registerSingleton<MovieApiService>(
      MovieApiServiceImpl(apiClient: apiClient),
    );
  }

  Future<void> removeApiService() async {
    await _diModule.unregisterSingleton<MovieApiService>();
  }

  Future<void> injectGoogleSignInService() async {
    await _diModule
        .registerSingleton<GoogleSignInService>(GoogleSignInService());
  }

  Future<void> removeGoogleSignInService() async {
    await _diModule.unregisterSingleton<GoogleSignInService>();
  }

  Future<void> injectLocalDataService() async {
    // TODO: Implement local service injection
    // Example:
    // await _diModule.registerSingleton<SharedPrefManager>(SharedPrefManager());
  }

  Future<void> removeLocalDataService() async {
    // TODO: Implement local service removal
    // Example:
    // await _diModule.unregisterSingleton<SharedPrefManager>();
  }

  Future<void> injectRepositories() async {
    final movieApiService = await _diModule.resolve<MovieApiService>();
    final supabaseService = await _diModule.resolve<SupabaseService>();
    final googleSignInService = await _diModule.resolve<GoogleSignInService>();
    final firebaseService =
        await _diModule.resolve<FirebaseNotificationService>();

    await _diModule.registerSingleton<MovieRepository>(
      MovieRepositoryImpl(movieApiService: movieApiService),
    );

    await _diModule.registerSingleton<AuthRepository>(AuthRepositoryImpl(
      googleSignInService: googleSignInService,
      supabaseService: supabaseService,
    ));

    await _diModule
        .registerSingleton<LocationRepository>(LocationRepositoryImpl());

    await _diModule.registerSingleton<EventRepository>(
        EventRepositoryImpl(supabaseService));

    await _diModule.registerSingleton<MemoryRepository>(
        MemoryRepositoryImpl(supabaseService: supabaseService));

    await _diModule.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(
      supabaseService: supabaseService,
    ));

    await _diModule.registerSingleton<IssueRepository>(
        IssueRepositoryImpl(supabaseService: supabaseService));

    await _diModule.registerSingleton<FirebaseRepository>(
      FirebaseRepositoryImpl(
        firebaseService: firebaseService,
      ),
    );
  }

  Future<void> removeRepositories() async {
    await _diModule.unregisterSingleton<IssueRepository>();
    await _diModule.unregisterSingleton<MemoryRepository>();
    await _diModule.unregisterSingleton<ProfileRepository>();
    await _diModule.unregisterSingleton<EventRepository>();
    await _diModule.unregisterSingleton<LocationRepository>();
    await _diModule.unregisterSingleton<AuthRepository>();
    await _diModule.unregisterSingleton<MovieRepository>();
  }
}
