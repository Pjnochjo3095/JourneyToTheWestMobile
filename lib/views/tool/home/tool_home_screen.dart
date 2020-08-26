import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/ToolViewModel.dart';
import 'package:journey_to_west/views/tool/home/tool_home_body.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolHomeScreen extends StatelessWidget {
  ToolViewModel model;

  ToolHomeScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ToolViewModel>(
      model: model,
      child: ToolHomeBody(),
    );
  }
}
