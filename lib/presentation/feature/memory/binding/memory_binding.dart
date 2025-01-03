import 'package:hello_flutter/presentation/base/base_binding.dart';

class MemoryBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // MemoryRepository memoryRepository = await diModule.resolve<MemoryRepository>();
    // return diModule.registerInstance(
    //   MemoryViewModel(memoryRepository: memoryRepository),
    // );
  }

  @override
  Future<void> removeDependencies() async {
    // return diModule.unregister<MemoryViewModel>();
  }
}
