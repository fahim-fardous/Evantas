import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_ui_state.dart';
import 'package:hello_flutter/presentation/feature/add_event/add_event_view_model.dart';

class AddEventMobilePortrait extends StatefulWidget {
  final AddEventViewModel viewModel;

  const AddEventMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => AddEventMobilePortraitState();
}

class AddEventMobilePortraitState extends BaseUiState<AddEventMobilePortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: valueListenableBuilder(
        listenable: widget.viewModel.message,
        builder: (context, value) {
          return InkWell(
            child: Text('AddEvent: $value'),
            onTap: () => widget.viewModel.onClick(),
          );
        },
      ),
    );
  }
}
