import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/add_event/route/add_event_argument.dart';

class AddEventViewModel extends BaseViewModel<AddEventArgument> {

  final ValueNotifier<String> _message = ValueNotifier('AddEvent');

  ValueListenable<String> get message => _message;

  int count = 0;

  AddEventViewModel();

  @override
  void onViewReady({AddEventArgument? argument}) {
    super.onViewReady();
  }

  void onClick() {
     count++;
    _message.value = '${message.value}$count';
  }

}
