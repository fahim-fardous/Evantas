import 'package:evntas/presentation/base/base_argument.dart';
import 'package:domain/model/event.dart';

class AddReminderArgument extends BaseArgument {
  final Event? existingEvent;
  final bool isEditable;

  AddReminderArgument({this.existingEvent, this.isEditable = true});
}
