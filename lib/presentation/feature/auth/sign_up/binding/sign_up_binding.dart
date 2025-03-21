import 'package:hello_flutter/presentation/base/base_binding.dart';
import 'package:hello_flutter/presentation/feature/auth/sign_up/sign_up_view_model.dart';

class SignUpBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // SignUpRepository signUpRepository = await diModule.resolve<SignUpRepository>();
    return diModule.registerInstance(
      SignUpViewModel(),
    );
  }

  @override
  Future<void> removeDependencies() async {
    // return diModule.unregister<SignUpViewModel>();
  }
}
