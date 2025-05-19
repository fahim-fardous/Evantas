import 'package:data/service/supabase_service.dart';
import 'package:domain/repository/memory_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/memory_details/memory_details_view_model.dart';

class MemoryDetailsBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    final MemoryRepository memoryDetailsRepository =
        await diModule.resolve<MemoryRepository>();
    final SupabaseService supabaseService =
        await diModule.resolve<SupabaseService>();

    return diModule.registerInstance(
      MemoryDetailsViewModel(
        memoryRepository: memoryDetailsRepository,
        supabaseService: supabaseService,
      ),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<MemoryDetailsViewModel>();
  }
}
