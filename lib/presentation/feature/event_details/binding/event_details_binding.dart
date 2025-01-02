import 'package:hello_flutter/presentation/base/base_binding.dart';

class EventDetailsBinding extends BaseBinding {
  @override
  Future<void> addDependencies() async {
    // EventDetailsRepository eventDetailsRepository = await diModule.resolve<EventDetailsRepository>();
    // return diModule.registerInstance(
    //   EventDetailsViewModel(eventDetailsRepository: eventDetailsRepository),
    // );
  }

  @override
  Future<void> removeDependencies() async {
    // return diModule.unregister<EventDetailsViewModel>();
  }
}
