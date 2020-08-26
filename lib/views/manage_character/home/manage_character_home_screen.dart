import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/manage_character/home/manage_character_home_body.dart';
import 'package:scoped_model/scoped_model.dart';

class ManageCharacterHomeScreen extends StatelessWidget {
  SceneViewModel model;
  ManageCharacterHomeScreen({this.model});
  @override
  Widget build(BuildContext context) {
    return ScopedModel<SceneViewModel>(
      model: model,
      child: ManageCharacterHomeBody(),
    );
  }
}
