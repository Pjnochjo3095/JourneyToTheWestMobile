import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/manage_character/add/manage_character_add_body.dart';
import 'package:scoped_model/scoped_model.dart';

class ManageCharacterAddScreen extends StatelessWidget {
  String id;
  SceneViewModel model;

  ManageCharacterAddScreen({this.id, this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<SceneViewModel>(model: model,child: ManageCharacterAddBody(id: id,),);
  }
}
