import 'package:evntas/presentation/app/app_viewmodel.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/settings/settings_view_model.dart';

class SettingsBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    AppViewModel appViewModel = await diModule.resolve<AppViewModel>();
    return diModule.registerInstance(
      SettingsViewModel(
        appViewModel: appViewModel,
      ),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<SettingsViewModel>();
  }
}
