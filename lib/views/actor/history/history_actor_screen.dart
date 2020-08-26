import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:journey_to_west/views/actor/history/history_actor_body.dart';
import 'package:scoped_model/scoped_model.dart';

class HistoryActorScreen extends StatelessWidget {
  ActorViewModel model;
  String id;

  HistoryActorScreen({this.model, this.id});

  @override
  Widget build(BuildContext context) {
    model.fetchScenesIsDone(id);
    return ScopedModel<ActorViewModel>(model: model,child: HisToryActorBody(),);
  }
}
