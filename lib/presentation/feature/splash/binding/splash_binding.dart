import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/splash/splash_view_model.dart';

class SplashBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    AppRepository appRepository = await diModule.resolve<AppRepository>();
    AuthRepository authRepository = await diModule.resolve<AuthRepository>();
    return diModule.registerInstance(
      SplashViewModel(
        appRepository: appRepository, authRepository: authRepository,),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<SplashViewModel>();
  }
}
