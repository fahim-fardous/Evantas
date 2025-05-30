import 'package:domain/repository/app_repository.dart';
import 'package:domain/repository/event_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/event_details/event_details_view_model.dart';

class EventDetailsBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // EventDetailsRepository eventDetailsRepository = await diModule.resolve<EventDetailsRepository>();
    EventRepository eventRepository = await diModule.resolve<EventRepository>();
    AppRepository appRepository = await diModule.resolve<AppRepository>();
    return diModule.registerInstance(
      EventDetailsViewModel(
        eventRepository,
        appRepository,
      ),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<EventDetailsViewModel>();
  }
}
