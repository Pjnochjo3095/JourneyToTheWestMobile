import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:journey_to_west/views/actor/character_list/list_character_of_user_body.dart';
import 'package:scoped_model/scoped_model.dart';

class ListCharacterOfUserScreen extends StatelessWidget {
  ActorViewModel model;
  String id;
  ListCharacterOfUserScreen({this.model, this.id});

  @override
  Widget build(BuildContext context) {
    model.fetchCharacters(id);
    return ScopedModel<ActorViewModel>(model: model, child: ListCharacterOfUserBody(),);
  }
}
