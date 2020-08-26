import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/ToolViewModel.dart';
import 'package:journey_to_west/views/tool/create/tool_create_body.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolCreateScreen extends StatelessWidget {
  ToolViewModel model;

  ToolCreateScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ToolViewModel>(model: model, child: ToolCreateBody(),);
  }
}
