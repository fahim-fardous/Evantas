import 'package:data/service/supabase_service.dart';
import 'package:hello_flutter/presentation/base/base_binding.dart';
import 'package:hello_flutter/presentation/feature/add_reminder/add_reminder_view_model.dart';

class AddReminderBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // AddReminderRepository createReminderRepository = await diModule.resolve<AddReminderRepository>();
    SupabaseService supabaseService = await diModule.resolve<SupabaseService>();
    return diModule.registerInstance(
      AddReminderViewModel(supabaseService: supabaseService),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<AddReminderViewModel>();
  }
}
