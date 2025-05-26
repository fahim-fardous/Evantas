import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/points/points_view_model.dart';

class PointsBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // PointsRepository pointsRepository = await diModule.resolve<PointsRepository>();
    return diModule.registerInstance(
      PointsViewModel(),
    );
  }

  @override
  Future<void> removeDependencies() async {
    // return diModule.unregister<PointsViewModel>();
  }
}
