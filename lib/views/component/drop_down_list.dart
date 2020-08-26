import 'package:flutter/material.dart';
import 'package:journey_to_west/models/Scene.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class DropDownList extends StatefulWidget {
  @override
  _DropDownListState createState() => _DropDownListState();
  List<Scene> listScene;
  DropDownList({this.listScene});
}

class _DropDownListState extends State<DropDownList> {

  List<String> listName= new List();
  String isSelect;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SceneViewModel>(builder: (context, child, model) {
      listName.clear();
      model.listScene.forEach((element) {
        listName.add(element.name);
      });
      if(listName != null && model.listScene != null){
        return Center(
          child: DropdownButton<String>(
           hint: Text("choose one"),
              items:listName.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18),),

                );
              }).toList(),
              onChanged: (String value) {
                setState(() {
                  isSelect = value;
                  model.fetchToolBySelected(model.listScene[listName.indexOf(value)].id);
                });
              },
              value: isSelect
          ),
        );
      }
      return Container();
    },);



  }
}
