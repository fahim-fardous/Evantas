import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/firebase_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/auth/login/login_view_model.dart';

class LoginBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    AuthRepository authRepository = await diModule.resolve<AuthRepository>();
    AppRepository appRepository = await diModule.resolve<AppRepository>();
    FirebaseRepository firebaseRepository = await diModule.resolve<FirebaseRepository>();
    return diModule.registerInstance(
      LoginViewModel(
        authRepository: authRepository,
        appRepository: appRepository,
        firebaseRepository: firebaseRepository,
      ),
    );
  }

  @override
  Future<void> removeDependencies() {
    return diModule.unregister<LoginViewModel>();
  }
}
