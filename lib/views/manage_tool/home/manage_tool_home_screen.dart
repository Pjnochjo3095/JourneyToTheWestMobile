import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/manage_tool/home/manage_tool_home_body.dart';
import 'package:scoped_model/scoped_model.dart';

class ManageToolHomeScreen extends StatelessWidget {
  @override
  SceneViewModel model;
  ManageToolHomeScreen({this.model});
  Widget build(BuildContext context) {

    return ScopedModel<SceneViewModel>(
      model: model,
      child: ManageToolHomeBody(),
    );

  }
}
