import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/event_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/event_list/event_list_view_model.dart';

class EventListBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // EventListRepository eventListRepository = await diModule.resolve<EventListRepository>();
    EventRepository eventRepository = await diModule.resolve<EventRepository>();
    AppRepository appRepository = await diModule.resolve<AppRepository>();
    return diModule.registerInstance(
      EventListViewModel(eventRepository, appRepository),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<EventListViewModel>();
  }
}
