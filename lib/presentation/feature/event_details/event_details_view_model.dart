import 'package:flutter/foundation.dart';
import 'package:hello_flutter/presentation/base/base_viewmodel.dart';
import 'package:hello_flutter/presentation/feature/event_details/route/event_details_argument.dart';

class EventDetailsViewModel extends BaseViewModel<EventDetailsArgument> {

  final ValueNotifier<String> _message = ValueNotifier('EventDetails');

  ValueListenable<String> get message => _message;

  int count = 0;

  EventDetailsViewModel();

  @override
  void onViewReady({EventDetailsArgument? argument}) {
    super.onViewReady();
  }

  void onClick() {
     count++;
    _message.value = '${message.value}$count';
  }

}
