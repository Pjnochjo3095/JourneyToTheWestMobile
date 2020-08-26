import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/statictis_tool/statictis_tool_body.dart';
import 'package:scoped_model/scoped_model.dart';

class StatictisToolScreen extends StatelessWidget {
  SceneViewModel model;

  StatictisToolScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<SceneViewModel>(
      model: model,
      child: StatictisToolBody(),
    );
  }
}
