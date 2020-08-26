import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:journey_to_west/views/actor/create_profile/create_profile_actor_body.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateProfileScreen extends StatelessWidget {
  ActorViewModel model;
  String id;
  CreateProfileScreen({this.model,this.id});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ActorViewModel>(model: model, child: CreateProfileBody(id: id,),);
  }
}
