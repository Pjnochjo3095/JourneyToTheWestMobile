import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/ToolViewModel.dart';
import 'package:journey_to_west/views/tool/edit/tool_edit_body.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolEditScreen extends StatelessWidget {
  ToolViewModel model;

  ToolEditScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ToolViewModel>(
      model: model,
      child: ToolEditBody(),
    );
  }
}
