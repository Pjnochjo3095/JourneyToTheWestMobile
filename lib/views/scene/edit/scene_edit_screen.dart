import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/scene/edit/scene_edit_body.dart';
import 'package:scoped_model/scoped_model.dart';

class SceneEditScreen extends StatelessWidget {
  SceneViewModel model;

  SceneEditScreen(this.model);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<SceneViewModel>(
      model: model,
      child: SceneEditBody(),
    );
  }
}
