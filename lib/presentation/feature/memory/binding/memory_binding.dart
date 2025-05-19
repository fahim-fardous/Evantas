import 'package:data/service/supabase_service.dart';
import 'package:domain/repository/memory_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/memory/memory_view_model.dart';

class MemoryBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    final SupabaseService supabaseService = await diModule.resolve<SupabaseService>();
    final MemoryRepository memoryRepository = await diModule.resolve<MemoryRepository>();
    return diModule.registerInstance(
      MemoryViewModel(supabaseService: supabaseService, memoryRepository: memoryRepository),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<MemoryViewModel>();
  }
}
