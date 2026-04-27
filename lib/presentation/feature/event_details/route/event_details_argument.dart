import 'package:evntas/presentation/base/base_argument.dart';

class EventDetailsArgument extends BaseArgument {
  int eventId;
  final String? createdBy;
  EventDetailsArgument({required this.eventId, this.createdBy});
}
