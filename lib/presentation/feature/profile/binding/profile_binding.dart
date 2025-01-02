import 'package:hello_flutter/presentation/base/base_binding.dart';

class ProfileBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // ProfileRepository profileRepository = await diModule.resolve<ProfileRepository>();
    // return diModule.registerInstance(
    //   ProfileViewModel(profileRepository: profileRepository),
    // );
  }

  @override
  Future<void> removeDependencies() async {
    // return diModule.unregister<ProfileViewModel>();
  }
}
