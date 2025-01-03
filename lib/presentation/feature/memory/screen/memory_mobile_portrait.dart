import 'package:flutter/material.dart';
import 'package:hello_flutter/presentation/base/base_ui_state.dart';
import 'package:hello_flutter/presentation/feature/memory/memory_view_model.dart';

class MemoryMobilePortrait extends StatefulWidget {
  final MemoryViewModel viewModel;

  const MemoryMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => MemoryMobilePortraitState();
}

class MemoryMobilePortraitState extends BaseUiState<MemoryMobilePortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: valueListenableBuilder(
        listenable: widget.viewModel.message,
        builder: (context, value) {
          return InkWell(
            child: Text('Memory: $value'),
            onTap: () => widget.viewModel.onClick(),
          );
        },
      ),
    );
  }
}
