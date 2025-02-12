import 'package:domain/repository/memory_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/image_viewer/image_viewer_view_model.dart';

class ImageViewerBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    MemoryRepository memoryRepository = await diModule.resolve<MemoryRepository>();
    return diModule.registerInstance(
      ImageViewerViewModel(memoryRepository: memoryRepository),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<ImageViewerViewModel>();
  }
}
