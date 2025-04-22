import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/profile_picture/profile_picture_view_model.dart';

class ProfilePictureBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // ProfilePictureRepository profilePictureRepository = await diModule.resolve<ProfilePictureRepository>();
    return diModule.registerInstance(
      ProfilePictureViewModel(),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<ProfilePictureViewModel>();
  }
}
