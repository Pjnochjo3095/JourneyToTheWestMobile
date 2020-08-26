import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:journey_to_west/views/actor/schedule/schedule_actor_body.dart';
import 'package:scoped_model/scoped_model.dart';

class ScheduleActorScreen extends StatelessWidget {
  ActorViewModel model;
  String id;
  ScheduleActorScreen({this.model, this.id});
  @override
  Widget build(BuildContext context) {
    model.fetchScenes(id);
    return ScopedModel<ActorViewModel>(model: model, child: ScheduleActorBody());
  }
}
