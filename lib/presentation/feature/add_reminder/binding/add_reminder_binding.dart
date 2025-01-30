import 'package:hello_flutter/presentation/base/base_binding.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/add_reminder_view_model.dart';

class AddReminderBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // AddReminderRepository createReminderRepository = await diModule.resolve<AddReminderRepository>();
    return diModule.registerInstance(
      AddReminderViewModel(),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<AddReminderViewModel>();
  }
}
