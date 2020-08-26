import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/models/Actor.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:journey_to_west/views/component/search_box.dart';

import 'package:scoped_model/scoped_model.dart';

class EnableActorBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ActorViewModel>(
        builder: (context, child, model) {
      if (!model.statusInit) {
        model.fetchActors();
        return Container();
      }else{
        if(model.listRoles.length > 0 && model.currentListActors.length > 0){
          return SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(40)),
                        ),
                      ),
                      ListView.builder(
                        itemCount: model.currentListActors.length,
                        itemBuilder: (context, index) => ActorCard(
                            itemIndex: index,
                            actor: model.currentListActors[index],
                            model: model,
                            role: model.listRoles[index]),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }else{
          model.notifyListeners();
          return Container();
        }

      }

    });
  }
}

class ActorCard extends StatelessWidget {
  const ActorCard({Key key, this.itemIndex, this.actor, this.model, this.role})
      : super(key: key);
  final int itemIndex;
  final Actor actor;
  final ActorViewModel model;
  final String role;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ActorViewModel>(
      builder: (context, child, model) {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          height: 80,
          child: Stack(
            children: <Widget>[
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      foregroundColor: Colors.white,
                      backgroundImage: NetworkImage(actor.image),
                    ),
                    title: Text(actor.name),
                    subtitle: Text(actor.decs),
                  ),
                ),
                actions: <Widget>[
                  IconSlideAction(
                    caption: actor.status ? "Enable": "Disable",
                    color: actor.status ? Colors.green : Colors.red,
                    icon: actor.status ? Icons.lock_open:Icons.lock,
                    onTap: () {
                      model.enableActor(actor.id, context);
                    },
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'isUser',
                    color: role!= null ?role.contains("User") ? Colors.green : Colors.black45 :Colors.black45,
                    icon: Icons.person,
                    onTap: (){
                      if(role.contains("User")){
                        model.deleteRoleUser(actor.id);
                      }else{
                        model.addRoleUser(actor.id);
                      }
                    },
                  ),
                  IconSlideAction(
                    caption: 'isAdmin',
                    color: role!= null?role.contains("Admin") ? Colors.green: Colors.black45 :Colors.black45,
                    icon: Icons.delete,
                    onTap: (){
                      if(role.contains("Admin")){
                        model.deleteRoleAdmin(actor.id);
                      }else{
                        model.addRoleAdmin(actor.id);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
