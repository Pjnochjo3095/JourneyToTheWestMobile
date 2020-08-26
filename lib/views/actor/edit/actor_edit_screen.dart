import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:journey_to_west/views/actor/edit/actor_edit_body.dart';
import 'package:scoped_model/scoped_model.dart';
class ActorEditScreen extends StatelessWidget {
  ActorViewModel model;
  String id;
  ActorEditScreen({this.model,this.id});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ActorViewModel>(model: model, child: ActorEditBody(id: id,),);
  }
}
