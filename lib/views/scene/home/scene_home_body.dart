import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/Component/search_box.dart';
import 'package:journey_to_west/views/Component/wukhong_background.dart';
import 'package:journey_to_west/views/scene/component/scene_card.dart';
import 'package:journey_to_west/views/scene/component/status_list.dart';
import 'package:journey_to_west/views/scene/create/scene_create_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class SceneHomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<SceneViewModel>(
        builder: (context, child, model) {
          if(!model.isChange){
            model.fetchScene();
            print("fetch");
          }
      return Scaffold(
          backgroundColor: SceneColor.secondaryBackgroundColor,
          appBar: AppBar(
            backgroundColor: SceneColor.primaryColor,
            elevation: 0,
            title: Text("Scene", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 28),),
          ),
          body: WukongBackground(
            child: SafeArea(
              bottom: true,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  SizedBox(height: 40,),
                  Align(
                    alignment: Alignment.center,
                    child: Text("List Scene", style: TextStyle(color: kTextColor, fontSize: 24),),
                  ),

                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.only(top: 50),
                          decoration: BoxDecoration(
                            color: kBackgroundColor.withOpacity(0.6),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(40)),
                          ),
                        ),
                        ListView.builder(
                          itemBuilder: (context, index) => SceneCard(
                            itemIndex: index,
                            scene: model.listScene[index],
                          ),
                          itemCount: model.listScene.length,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed:(){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SceneCreateScene(
                        model: model,
                      )));
            },
            backgroundColor: SceneColor.primaryColor,
            child: Icon(
                Icons.add
            ),
          )
      );

    });
  }
}
