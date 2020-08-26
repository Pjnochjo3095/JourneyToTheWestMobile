import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';

import 'package:scoped_model/scoped_model.dart';

import 'enable_actor_body.dart';

class EnableActorScreen extends StatelessWidget {
  ActorViewModel model;

  EnableActorScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ActorViewModel>(
      model: model,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text("Enable Actor", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 28),),
          ),
          body: EnableActorBody(),
    ),);
  }
}
