import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/manage_tool/add/manage_tool_add_body.dart';
import 'package:scoped_model/scoped_model.dart';

class ManageToolAddScreen extends StatelessWidget {
  SceneViewModel model;
  String id;
  ManageToolAddScreen({this.model, this.id});
  @override
  Widget build(BuildContext context) {
    model.homeModel.fetchCurrentUser(context);
    return ScopedModel<SceneViewModel>(model: model, child: ManageToolAddBody(id: id,),);
  }
}
