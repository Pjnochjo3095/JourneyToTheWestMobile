import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/scene/edit/scene_edit_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../bottom_nav_bar.dart';

class SceneDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SceneViewModel>(
      builder: (context, child, model) {
        if (model.currentScene != null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: SceneColor.primaryColor,
              elevation: 0,
              title: new Text(
                "Scene",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 32),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SceneEditScreen(model);
                  },
                ));
              },
              backgroundColor: SceneColor.primaryColor,
              child: Icon(Icons.edit),
            ),
            body: Container(
              color: SceneColor.layoutColor,
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                      left: kDefaultPadding, right: kDefaultPadding),
                  decoration: BoxDecoration(
                    color: SceneColor.backgroundColor,
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          ListTile(
                            leading: new Icon(
                              Icons.bookmark,
                              color: SceneColor.primaryColor,
                              size: 30.0,
                            ),
                            title: new Text(
                              "Name",
                              style: new TextStyle(fontWeight: FontWeight.w400),
                            ),
                            subtitle: new Text(model.currentScene != null
                                ? model.currentScene.name
                                : ""),
                          ),
                        ],
                      ),
                      new Divider(
                        color: SceneColor.secondaryColor,
                        indent: 0,
                        thickness: 1,
                      ),
                      ListTile(
                        leading: new Icon(
                          Icons.description,
                          color: SceneColor.primaryColor,
                          size: 30.0,
                        ),
                        title: new Text(
                          "Description",
                          style: new TextStyle(fontWeight: FontWeight.w400),
                        ),
                        subtitle: new Text(model.currentScene != null
                            ? model.currentScene.desc
                            : ""),
                      ),
                      new Divider(
                        color: SceneColor.secondaryColor,
                        indent: 0,
                        thickness: 1,
                      ),
                      ListTile(
                        leading: new Icon(
                          Icons.location_on,
                          color: SceneColor.primaryColor,
                          size: 30.0,
                        ),
                        title: new Text(
                          "Location",
                          style: new TextStyle(fontWeight: FontWeight.w400),
                        ),
                        subtitle: new Text(model.currentScene != null
                            ? model.currentScene.location
                            : ""),
                      ),
                      new Divider(
                        color: SceneColor.secondaryColor,
                        indent: 0,
                        thickness: 1,
                      ),
                      ListTile(
                        leading: new Icon(
                          Icons.slideshow,
                          color: SceneColor.primaryColor,
                          size: 30.0,
                        ),
                        title: new Text(
                          "Snapshot",
                          style: new TextStyle(fontWeight: FontWeight.w400),
                        ),
                        subtitle: new Text(model.currentScene != null
                            ? model.currentScene.snapshot.toString()
                            : ""),
                      ),
                      new Divider(
                        color: SceneColor.secondaryColor,
                        indent: 0,
                        thickness: 1,
                      ),
                      ListTile(
                        leading: new Icon(
                          Icons.calendar_today,
                          color: SceneColor.primaryColor,
                          size: 30.0,
                        ),
                        title: new Text(
                          "Time Start",
                          style: new TextStyle(fontWeight: FontWeight.w400),
                        ),
                        subtitle: new Text(model.currentScene != null
                            ? model.currentScene.begin
                                .toString()
                                .split("T")[0]
                                .toString()
                            : ""),
                      ),
                      new Divider(
                        color: SceneColor.secondaryColor,
                        indent: 0,
                        thickness: 1,
                      ),
                      ListTile(
                        leading: new Icon(
                          Icons.calendar_today,
                          color: SceneColor.primaryColor,
                          size: 30.0,
                        ),
                        title: new Text(
                          "Time End",
                          style: new TextStyle(fontWeight: FontWeight.w400),
                        ),
                        subtitle: new Text(model.currentScene != null
                            ? model.currentScene.end
                                .toString()
                                .split("T")[0]
                                .toString()
                            : ""),
                      ),
                      new Divider(
                        color: SceneColor.secondaryColor,
                        indent: 0,
                        thickness: 1,
                      ),
                      ListTile(
                        leading: new Icon(
                          Icons.ac_unit,
                          color: SceneColor.primaryColor,
                          size: 30.0,
                        ),
                        title: new Text(
                          "Status",
                          style: new TextStyle(fontWeight: FontWeight.w400),
                        ),
                        subtitle: new Text(model.currentScene != null
                            ? model.currentScene.status
                            : ""),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              height: 80,
              color: SceneColor.layoutColor,
              child: model.currentScene.status == "Delete" || model.currentScene.status == "Done"?
                  Container(color: Colors.transparent,)
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  BottomNavItem(
                    press: () {
                      model.finish(model.currentScene.id, context);
                    },
                    svgSrc: "assets/icons/003-check.svg",
                    title: "Done",
                    isActive: false,
                  ),
                  BottomNavItem(
                    press: () {
                      model.delete(model.currentScene.id, context);
                    },
                    svgSrc: "assets/icons/002-dustbin.svg",
                    title: "Delete",
                    isActive: false,
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          color: Colors.white,
        );
      },
    );
  }
}
