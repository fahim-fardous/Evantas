import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/memory/route/memory_argument.dart';

class MemoryViewModel extends BaseViewModel<MemoryArgument> {

  final ValueNotifier<String> _message = ValueNotifier('Memory');

  ValueListenable<String> get message => _message;

  int count = 0;

  MemoryViewModel();

  @override
  void onViewReady({MemoryArgument? argument}) {
    super.onViewReady();
  }

  void onClick() {
     count++;
    _message.value = '${message.value}$count';
  }

}
