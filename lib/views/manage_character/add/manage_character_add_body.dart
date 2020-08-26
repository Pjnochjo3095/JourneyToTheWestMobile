import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/component/round_btn.dart';
import 'package:journey_to_west/views/component/wukhong_background.dart';
import 'package:scoped_model/scoped_model.dart';

class ManageCharacterAddBody extends StatelessWidget {
  @override
  String id;

  ManageCharacterAddBody({this.id});

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant<SceneViewModel>(builder: (context, child, model) {
      model.actorModel.fetchActors();
      if(model.actorModel.currentListActors.length > 0){
        return Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: Text(
                "Add Character To Scene",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              backgroundColor: SceneColor.primaryColor,
            ),
            body: WukongBackground(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: size.width,
                        alignment: Alignment.center,
                        child: Text(
                          "Add Character Form",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ListTile(
                          leading: Icon(Icons.title, color: SceneColor.activeColor),
                          title: DropDownCharacter()),
                      //DropDownTool()
                      ListTile(
                        leading: Icon(Icons.person, color: SceneColor.activeColor),
                        title: TextField(
                          decoration: InputDecoration(hintText: "character"),
                          onChanged: (value) {
                            model.changeText("character", value);
                          },
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.description, color: SceneColor.activeColor),
                        title: TextField(
                          decoration: InputDecoration(hintText: "description"),
                          onChanged: (value) {
                            model.changeText("desc", value);
                          },
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.note, color: SceneColor.activeColor,),
                        title: RaisedButton(onPressed: ()async {
                          File file = await FilePicker.getFile();
                          model.scriptLink = file;
                        }, child: Text("choose file"),),
                      ),
                      model.scriptLink != null ? ListTile(
                        leading: Icon(Icons.note,color: SceneColor.activeColor,),
                        title: Icon(Icons.done, color: Colors.green,),
                      ) : Text(""),

                      RoundBtn(
                        title: "Add Character",
                        press: () {
                            model.addCharacter(context);
                        },
                        color: SceneColor.primaryColor,
                        textColor: kTextColor,
                      ),
                    ],
                  ),
                ),
              ),
            ));
      }
      model.notifyListeners();
      return Container(
        color: Colors.white,
      );
    },);
  }
}

class DropDownCharacter extends StatefulWidget {
  @override
  _DropDownCharacterState createState() => _DropDownCharacterState();
}

class _DropDownCharacterState extends State<DropDownCharacter> {
  String isSelect;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SceneViewModel>(
      builder: (context, child, model) {
        model.listName.clear();
        model.actorModel.currentListActors.forEach((element) {
          model.listName.add(element.name + ":" + element.email);
        });
        if (model.listName != null && model.actorModel.currentListActors != null) {
          return DropdownButton<String>(
            hint: Text("choose one"),
            items: model.listName.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                ),
              );
            }).toList(),
            onChanged: (String value) {
              setState(() {
                isSelect = value != null ? value : "";
                model.changeIdOfCharacter(
                    model.actorModel.currentListActors[model.listName.indexOf(value)].id);
              });
            },
            value: isSelect,
            isExpanded: true,
          );
        }
        return Container();
      },
    );
  }
}
