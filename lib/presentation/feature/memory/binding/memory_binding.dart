import 'package:domain/repository/memory_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/memory/memory_view_model.dart';

class MemoryBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    MemoryRepository memoryRepository = await diModule.resolve<MemoryRepository>();
    return diModule.registerInstance(
      MemoryViewModel(memoryRepository: memoryRepository),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<MemoryViewModel>();
  }
}
