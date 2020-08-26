import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/component/round_btn.dart';
import 'package:journey_to_west/views/component/wukhong_background.dart';
import 'package:scoped_model/scoped_model.dart';

class SceneEditBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<SceneViewModel>(builder: (context, child, model) {
      if(model.currentScene != null){
        if(!model.isChange){
          model.prepareEdit();
        }
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: SceneColor.primaryColor,
          elevation: 0,
          title: Text(
            "Edit Scene",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 32),
          ),

        ),
        body: WukongBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("EDIT SCENE FORM",
                      style: TextStyle(
                        fontSize: 30,
                        letterSpacing: .6,
                        fontFamily: "Poppins-Medium",
                      )),
                  SizedBox(height: 40,),
                  ListTile(
                    leading: Icon(Icons.bookmark, color: SceneColor.activeColor,),
                    title: TextField(
                      controller: model.initName,
                      decoration: InputDecoration(hintText: "Your scene name"),
                      onChanged: (value) {
                        model.changeText("name", value);
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.description, color: SceneColor.activeColor),
                    title: TextField(
                      controller: model.initDesc,
                      decoration: InputDecoration(hintText: "Your desciption"),
                      onChanged: (value) {
                        model.changeText("desc", value);
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on, color: SceneColor.activeColor),
                    title: TextField(
                      controller: model.initLocation,
                      decoration: InputDecoration(hintText: "Your Location"),
                      onChanged: (value) {
                        model.changeText("location", value);
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.slideshow, color: SceneColor.activeColor),
                    title: TextField(
                      controller: model.initSnapshot,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value) {
                        model.changeText("snapshot", value);
                      },
                      decoration: InputDecoration(
                          hintText: "Snapshot",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 12.0),
                          border: InputBorder.none),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.date_range, color: SceneColor.activeColor),
                    title: FlatButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2018, 3, 5),
                              theme: DatePickerTheme(
                                headerColor: SceneColor.primaryColor,
                                backgroundColor: SceneColor.backgroundColor,
                                itemStyle: TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                doneStyle:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ), onConfirm: (date) {
                                model.setTime("begin", date);
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                        child: Text(model.begin != null
                            ? model.begin.toString().split(" ")[0].toString() : model.currentScene.begin != null ? model.currentScene.begin.split("T")[0].toString()
                            : "Choice Start Date")),
                  ),
                  ListTile(
                    leading: Icon(Icons.date_range, color: SceneColor.activeColor),
                    title: FlatButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2018, 3, 5),
                              theme: DatePickerTheme(
                                  headerColor: SceneColor.primaryColor,
                                  backgroundColor: SceneColor.backgroundColor,
                                  itemStyle: TextStyle(
                                      color: kTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  doneStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16)), onConfirm: (date) {
                                model.setTime("end", date);
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                        child: Text(model.end != null
                            ? model.end.toString().split(" ")[0].toString() : model.currentScene.end != null ? model.currentScene.end.split("T")[0].toString()
                            : "Choice End Date")),
                  ),
                  RoundBtn(
                    title: "EDIT",
                    press: () {
                      model.update(context);
                    },
                    color: SceneColor.primaryColor,
                    textColor: kTextColor,
                  ),
                  RoundBtn(
                    title: "CANCEL",
                    press: () {
                      Navigator.of(context).pop();
                    },
                    color: SceneColor.secondaryColor,
                    textColor: kTextColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },);
  }
}
