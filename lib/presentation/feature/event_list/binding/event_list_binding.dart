import 'package:domain/repository/event_repository.dart';
import 'package:hello_flutter/presentation/base/base_binding.dart';
import 'package:hello_flutter/presentation/feature/event_list/event_list_view_model.dart';

class EventListBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // EventListRepository eventListRepository = await diModule.resolve<EventListRepository>();
    EventRepository eventRepository = await diModule.resolve<EventRepository>();
    return diModule.registerInstance(
      EventListViewModel(eventRepository),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<EventListViewModel>();
  }
}
