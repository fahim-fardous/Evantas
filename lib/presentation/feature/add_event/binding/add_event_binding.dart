import 'package:evntas/presentation/base/base_binding.dart';

class AddEventBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // AddEventRepository addEventRepository = await diModule.resolve<AddEventRepository>();
    // return diModule.registerInstance(
    //   AddEventViewModel(addEventRepository: addEventRepository),
    // );
  }

  @override
  Future<void> removeDependencies() async {
    // return diModule.unregister<AddEventViewModel>();
  }
}
