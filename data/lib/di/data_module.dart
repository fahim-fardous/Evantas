import 'package:data/remote/api_client/api_client.dart';
import 'package:data/remote/api_client/movie_api_client.dart';
import 'package:data/remote/api_service/movie_api_service.dart';
import 'package:data/remote/api_service/movie_api_service_impl.dart';
import 'package:data/repository/auth_repository_impl.dart';
import 'package:data/repository/event_repository_impl.dart';
import 'package:data/repository/location_repository_impl.dart';
import 'package:data/repository/memory_repository_impl.dart';
import 'package:data/repository/movie_repository_impl.dart';
import 'package:data/service/google_api_service.dart';
import 'package:data/service/supabase_service.dart';
import 'package:domain/di/di_module.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/event_repository.dart';
import 'package:domain/repository/location_repository.dart';
import 'package:domain/repository/memory_repository.dart';
import 'package:domain/repository/movie_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataModule {
  DataModule._internal();

  static final DataModule _instance = DataModule._internal();

  factory DataModule() => _instance;

  final DiModule _diModule = DiModule();

  Future<void> injectDependencies() async {
    await injectGoogleSignInService();
    await injectSupabaseService();
    await injectApiClient();
    await injectApiService();
    await injectLocalDataService();
    await injectRepositories();
  }

  Future<void> removeDependencies() async {
    await removeSupabaseService();
    await removeApiClient();
    await removeApiService();
    await removeLocalDataService();
    await removeRepositories();
  }

  Future<void> injectGoogleSignInService() async {
    await _diModule.registerSingleton<GoogleSignInService>(
      GoogleSignInService(),
    );
  }

  Future<void> injectSupabaseService() async {
    final supabaseClient = Supabase.instance.client;
    await _diModule.registerSingleton<SupabaseService>(
      SupabaseService(
        supabaseClient: supabaseClient,
      ),
    );
  }

  Future<void> removeGoogleSignInService() async {
    await _diModule.unregisterSingleton<GoogleSignInService>();
  }

  Future<void> removeSupabaseService() async {
    await _diModule.unregisterSingleton<SupabaseService>();
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

  Future<void> injectLocalDataService() async {
    //TODO: Implement local service injection
  }

  Future<void> removeLocalDataService() async {}

  Future<void> injectRepositories() async {
    final movieApiService = await _diModule.resolve<MovieApiService>();
    final supabaseService = await _diModule.resolve<SupabaseService>();
    final googleSignInService = await _diModule.resolve<GoogleSignInService>();
    await _diModule.registerSingleton<MovieRepository>(
      MovieRepositoryImpl(movieApiService: movieApiService),
    );

    await _diModule.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(
        googleSignInService: googleSignInService,
      ),
    );

    await _diModule
        .registerSingleton<LocationRepository>(LocationRepositoryImpl());

    await _diModule.registerSingleton<EventRepository>(
        EventRepositoryImpl(supabaseService));

    await _diModule
        .registerSingleton<MemoryRepository>(MemoryRepositoryImpl(supabaseService: supabaseService));
  }

  Future<void> removeRepositories() async {
    await _diModule.unregisterSingleton<MovieRepository>();
    await _diModule.unregisterSingleton<AuthRepository>();
    await _diModule.unregisterSingleton<LocationRepository>();
    await _diModule.unregisterSingleton<EventRepository>();
  }
}
