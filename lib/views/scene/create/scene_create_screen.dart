import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/scene/create/scene_create_body.dart';
import 'package:scoped_model/scoped_model.dart';

class SceneCreateScene extends StatelessWidget {
  SceneViewModel model;

  SceneCreateScene({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<SceneViewModel>(
      model: model,
      child: Scaffold(
        backgroundColor: SceneColor.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Create Scene",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 32),
          ),

        ),
        body: SceneCreateBody(),
      ),
    );
  }
}
