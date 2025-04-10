import 'package:data/service/supabase_service.dart';
import 'package:hello_flutter/presentation/base/base_binding.dart';
import 'package:hello_flutter/presentation/feature/memory/memory_view_model.dart';

class MemoryBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    final SupabaseService supabaseService = await diModule.resolve<SupabaseService>();
    return diModule.registerInstance(
      MemoryViewModel(supabaseService: supabaseService),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<MemoryViewModel>();
  }
}
