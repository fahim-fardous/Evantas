import 'package:hello_flutter/presentation/base/base_binding.dart';
import 'package:hello_flutter/presentation/feature/event_details/event_details_view_model.dart';

class EventDetailsBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // EventDetailsRepository eventDetailsRepository = await diModule.resolve<EventDetailsRepository>();
    return diModule.registerInstance(
      EventDetailsViewModel(),
    );
  }

  @override
  Future<void> removeDependencies() async {
    return diModule.unregister<EventDetailsViewModel>();
  }
}
