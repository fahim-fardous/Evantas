import 'package:domain/repository/event_repository.dart';
import 'package:evntas/presentation/base/base_binding.dart';
import 'package:evntas/presentation/feature/add_reminder/add_reminder_view_model.dart';

class AddReminderBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    EventRepository eventRepository = await diModule.resolve<EventRepository>();
    return diModule.registerInstance(
      AddReminderViewModel(eventRepository: eventRepository),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<AddReminderViewModel>();
  }
}
