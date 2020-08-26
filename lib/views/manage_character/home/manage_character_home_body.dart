import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/models/Scene.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/component/wukhong_background.dart';
import 'package:journey_to_west/views/manage_character/add/manage_character_add_screen.dart';
import 'package:journey_to_west/views/manage_tool/add/manage_tool_add_body.dart';
import 'package:journey_to_west/views/manage_tool/add/manage_tool_add_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ManageCharacterHomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant<SceneViewModel>(
      builder: (context, child, model) {
        if (!model.isChange) {
          model.fetchScene();
        }
        if (model.listScene.length > 0) {
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: Text(
                "Manage Character",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            body: WukongBackground(
              child: Container(
                width: size.width,
                height: size.height,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: size.width,
                      height: size.height * 0.1,
                      child: Text(
                        "All Character Of Scene",
                        style: TextStyle(fontSize: 24),
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                        width: size.width,
                        height: size.height * 0.12,
                        child: DropDownCharacter()),
                    Expanded(
                      child: Container(
                        width: size.width,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Character List",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: kTextColor),
                            ),
                            model.listCharacters.length == 0
                                ? Expanded(
                                    child: Center(
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "This scene don't have any character",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 30),
                                          )),
                                    ),
                                  )
                                : Expanded(
                                    child: Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: ListView.builder(
                                        itemCount: model.listCharacters.length,
                                        itemBuilder: (context, index) =>
                                            Container(
                                              width: size.width,
                                              height: 200,
                                              child: Container(
                                                height: 180,
                                                decoration: BoxDecoration(
                                                    color: index % 2 == 0
                                                        ? SceneColor
                                                            .layoutColor
                                                        : SceneColor
                                                            .secondaryBackgroundColor,
                                                    boxShadow: [
                                                      kDefaultShadow
                                                    ]),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(22)),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        width: size.width,
                                                        child: ListTile(
                                                          contentPadding: EdgeInsets.all(kDefaultPadding/2),
                                                          leading: CircleAvatar(backgroundImage: NetworkImage(model.listCharacters[index].actorImage),),
                                                          title: Text("Actor : " + model.listCharacters[index].actorName, style: TextStyle(fontSize: 18, color: kTextColor),),
                                                          subtitle: Text("Character : " + model.listCharacters[index].character, style: TextStyle(fontSize: 18, color: kTextColor),),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: ListTile(
                                                          title: Text("Description : " + model.listCharacters[index].description, style: TextStyle(fontSize: 18, color: kTextColor),),
                                                          trailing: RaisedButton(

                                                            onPressed: () async {
                                                              if (await canLaunch(
                                                                  model.listCharacters[index].scriptLink)) {
                                                                await launch(
                                                                    model.listCharacters[index].scriptLink);
                                                              }
                                                            },
                                                            child: Icon(Icons.book),
                                                            color: Colors.blue.withOpacity(0.5),
                                                            colorBrightness: Brightness.light,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: Alignment.center,
                                                        width: 50,
                                                        height: 50,
                                                        color: Colors.black.withOpacity(0.1),
                                                        child: InkWell(
                                                          child: SvgPicture.asset(
                                                            "assets/icons/002-dustbin.svg",
                                                            color: kTextColor,width: 30, height: 30,),
                                                          onTap: () {
                                                            model.deleteCharacter(
                                                                model.listCharacters[index]
                                                                    .id, context);
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              margin: EdgeInsets.only(bottom: 20),
                                            )),
                                  ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: model.idForAddCharacter != null
                ? FloatingActionButton(
              backgroundColor: SceneColor.primaryColor,
                    onPressed: () {
                      if (model.idForAddCharacter != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageCharacterAddScreen(
                                      model: model,
                                      id: model.idForAddTool,
                                    )));
                      }
                    },
                    child: Icon(Icons.add),
                  )
                : Container(),
          );
        }
        model.notifyListeners();
        return Container(
          color: Colors.white,
        );
      },
    );
  }
}

class DropDownCharacter extends StatefulWidget {
  @override
  _DropDownCharacterState createState() => _DropDownCharacterState();
  List<Scene> listScene;

  DropDownCharacter({this.listScene});
}

class _DropDownCharacterState extends State<DropDownCharacter> {
  List<String> listName = new List();
  String isSelect;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SceneViewModel>(
      builder: (context, child, model) {
        listName.clear();
        model.listScene.forEach((element) {
          listName.add(element.name);
        });
        if (listName != null && model.listScene != null) {
          return Center(
            child: DropdownButton<String>(
                hint: Text("choose one"),
                items: listName.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    isSelect = value;
                    model.fecthCharacterBySelected(
                        model.listScene[listName.indexOf(value)].id);
                  });
                },
                value: isSelect),
          );
        }
        return Container();
      },
    );
  }
}
