import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:journey_to_west/views/actor/detail/actor_detail_body.dart';
import 'package:scoped_model/scoped_model.dart';

class ActorDetailScreen extends StatelessWidget {
  ActorViewModel model;
  String id;
  ActorDetailScreen({this.model,this.id});

  @override
  Widget build(BuildContext context) {
    model.getActorById(id);
    return ScopedModel<ActorViewModel>(model: model,child: ActorDetailBody(),);
  }
}
