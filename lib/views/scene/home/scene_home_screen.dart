import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/scene/home/scene_home_body.dart';
import 'package:scoped_model/scoped_model.dart';

class SceneScreen extends StatelessWidget {
  SceneViewModel model;
  SceneScreen({this.model});

  @override
  Widget build(BuildContext context) {

    return ScopedModel<SceneViewModel>(model: model,
      child: SceneHomeBody()
    );
  }


}
