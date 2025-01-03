import 'package:flutter/foundation.dart';
import 'package:hello_flutter/presentation/base/base_viewmodel.dart';
import 'package:hello_flutter/presentation/feature/memory/route/memory_argument.dart';

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
