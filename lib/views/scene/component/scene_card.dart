import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/models/Scene.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/scene/detail/scene_detail_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class SceneCard extends StatelessWidget {
  const SceneCard({
    Key key,
    this.itemIndex,
    this.scene,
  }) : super(key: key);
  final int itemIndex;
  final Scene scene;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant<SceneViewModel>(builder: (context, child, model) {
      return Container(
        margin: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        height: 120,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return SceneDetailScreen(model, scene.id);
              },
            ));
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color:
                    itemIndex % 2 == 0 ? kCardSceneColor : kCardSceneColor2,
                    boxShadow: [kDefaultShadow]),
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22)),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      width: size.width * 0.45,
                      child: Text(
                        "Scene",
                        style: TextStyle(color: kTextColor, fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      width: size.width * 0.45,
                      child: Text(
                        scene.name,
                        style: TextStyle(color: kTextColor, fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      width: size.width * 0.2,
                      height: size.height * 0.03,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: scene.status == StatusScene.NEW
                              ? kBackgroundBehindColor
                              : scene.status == StatusScene.PROCESSING
                              ? Colors.blue
                              : scene.status == StatusScene.DONE
                              ? Colors.green
                              : Colors.red),
                      child: Text(scene.status),
                    )
                  ],
                ),
              ),
              Positioned(
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Time Start ",
                      style: TextStyle(color: kTextColor, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      scene.begin.toString().split("T")[0].toString(),
                      style: TextStyle(color: kTextColor, fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Time End ",
                      style: TextStyle(color: kTextColor, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      scene.end.toString().split("T")[0].toString(),
                      style: TextStyle(color: kTextColor, fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },);
  }
}
