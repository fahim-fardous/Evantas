import 'package:flutter/foundation.dart';
import 'package:evntas/presentation/base/base_viewmodel.dart';
import 'package:evntas/presentation/feature/points/route/points_argument.dart';

class PointsViewModel extends BaseViewModel<PointsArgument> {

  final ValueNotifier<String> _message = ValueNotifier('Points');

  ValueListenable<String> get message => _message;

  int count = 0;

  PointsViewModel();

  @override
  void onViewReady({PointsArgument? argument}) {
    super.onViewReady();
  }

  void onBackPressed(){
    navigateBack();
  }
}
