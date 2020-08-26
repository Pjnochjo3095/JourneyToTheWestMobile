import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/scene/detail/scene_detail_body.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class SceneDetailScreen extends StatelessWidget {
  SceneViewModel model;
  String id;

  SceneDetailScreen(this.model, this.id);
  @override
  Widget build(BuildContext context) {
    model.getSceneById(id);
    return ScopedModel<SceneViewModel>(
      model: model,
      child: SceneDetailBody()
    );
  }
}
