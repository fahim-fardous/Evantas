import 'package:hello_flutter/presentation/base/base_binding.dart';
import 'package:hello_flutter/presentation/feature/event_list/event_list_view_model.dart';

class EventListBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // EventListRepository eventListRepository = await diModule.resolve<EventListRepository>();
    return diModule.registerInstance(
      EventListViewModel(),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<EventListViewModel>();
  }
}
