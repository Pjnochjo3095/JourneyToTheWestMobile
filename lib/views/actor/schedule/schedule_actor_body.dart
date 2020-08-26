import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ScheduleActorBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant<ActorViewModel>(
      builder: (context, child, model) {
        if (model.listScenes != null) {
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: Text(
                "List Scene is processing",
                style: TextStyle(fontSize: 20),
              ),
            ),
            body: model.listScenes.length == 0
                ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "You don't have any schedule",
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      itemCount: model.listScenes.length,
                      itemBuilder: (context, index) {
                        return Container(
                            width: size.width,
                            height: 200,
                            margin: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            decoration: BoxDecoration(
                                boxShadow: [kDefaultShadow],
                                border: Border.all(
                                    color: kTextColor,
                                    style: BorderStyle.solid,
                                    width: 0.5)),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              title: Text(
                                  "SceneName : " + model.listScenes[index].name,
                                  style: TextStyle(
                                      fontSize: 24, color: kTextColor)),
                              subtitle: GridView.count(
                                primary: false,
                                crossAxisCount: 2,
                                  padding: const EdgeInsets.all(5),
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 1,
                                childAspectRatio: 3.5,
                                children: <Widget>[
                                  Text(
                                      "Location : " +
                                          model.listScenes[index].location,
                                      style: TextStyle(
                                          fontSize: 18, color: kTextColor)),
                                  Text(
                                      "Description : " +
                                          model.listScenes[index].desc,
                                      style: TextStyle(
                                          fontSize: 18, color: kTextColor)),
                                  Text(
                                      "Start : " +
                                          model.listScenes[index].begin.split("T")[0],
                                      style: TextStyle(
                                          fontSize: 18, color: kTextColor)),
                                  Text("End : " + model.listScenes[index].end.split("T")[0],
                                      style: TextStyle(
                                          fontSize: 18, color: kTextColor)),
                                  Text("Character : " + model.listScenes[index].character,
                                      style: TextStyle(
                                          fontSize: 18, color: kTextColor)),
                                ],
                              ),
                            ));
                      },
                    ),
                  ),
          );
        }
        return Container();
      },
    );
  }
}
