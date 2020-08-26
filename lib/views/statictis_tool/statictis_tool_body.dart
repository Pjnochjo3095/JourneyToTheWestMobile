import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class StatictisToolBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant<SceneViewModel>(
      builder: (context, child, model) {
        if(!model.isDoneOrder){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Statictis tool",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
            ),
            body: Container(
              width: size.width,
              height: size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    height: size.height * 0.25,
                    padding:
                    EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.black.withOpacity(0.2))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Choose day",
                          style: TextStyle(fontSize: 24, color: kTextColor),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        ListTile(
                          leading: Icon(Icons.date_range,
                              color: SceneColor.activeColor),
                          title: FlatButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2015, 1, 1),
                                    theme: DatePickerTheme(
                                      headerColor: SceneColor.primaryColor,
                                      backgroundColor: SceneColor.backgroundColor,
                                      itemStyle: TextStyle(
                                          color: kTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      doneStyle: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ), onConfirm: (date) {
                                      model.setTime("begin", date);
                                    },
                                    currentTime: DateTime(2015, 1, 1),
                                    locale: LocaleType.en);
                              },
                              child: Text(model.begin != null
                                  ? model.begin
                                  .toString()
                                  .split(" ")[0]
                                  .toString()
                                  : "Choice Start Date")),
                        ),
                        ListTile(
                          leading: Icon(Icons.date_range,
                              color: SceneColor.activeColor),
                          title: FlatButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2015, 1, 1),
                                    theme: DatePickerTheme(
                                      headerColor: SceneColor.primaryColor,
                                      backgroundColor: SceneColor.backgroundColor,
                                      itemStyle: TextStyle(
                                          color: kTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      doneStyle: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ), onConfirm: (date) {
                                      model.setTime("end", date);
                                    },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Text(model.end != null
                                  ? model.end.toString().split(" ")[0].toString()
                                  : "Choice End Date")),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        InkWell(
                          onTap: () {
                            model.getAllOrder();
                          },
                          child: Container(
                              width: 100,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: SceneColor.activeColor),
                              child: Text(
                                "Find",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                  model.listOrder.length > 0 && model.listOrder != null
                      ? Container(
                      height: size.height * 0.63,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Container(
                          height: size.height * 0.3,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                contentPadding: EdgeInsets.all(8),
                                leading: Container(
                                  width: 80,
                                  height: 80,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      model.listOrder[index].image,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "Name : " + model.listOrder[index].name,
                                  style: TextStyle(fontSize: 18),
                                ),
                                subtitle: Text(
                                  "Scene Name: " +
                                      model.listOrder[index].sceneName,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      "From : " +
                                          model.listOrder[index].borrowFrom.split("T")[0],
                                      style: TextStyle(fontSize: 18)),
                                  Text(
                                      "To : " +
                                          model.listOrder[index].borrowTo.split("T")[0],
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      "Amount : " +
                                          model.listOrder[index].amount.toString(),
                                      style: TextStyle(fontSize: 18)),
                                  Container(
                                    height: 50,
                                    width: 100,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: model.listOrder[index].status != StatusOrder.NEW ? Colors.red : Colors.green,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child:  Text(model.listOrder[index].status,
                                        style: TextStyle(fontSize: 18)),
                                  )
                                ],
                              ),
                              Divider(thickness: 1,)
                            ],
                          ),
                        ),
                        itemCount: model.listOrder.length,
                      ))
                      : Container(
                    height: size.height * 0.63,
                    width: size.width,
                    alignment: Alignment.center,
                    child: Text("Don't have any order"),
                  )
                ],
              ),
            ),
          );
        }else{
          model.isDoneOrder = false;
          model.notifyListeners();
          return Container(
            color: Colors.white,
          );
        }

      },
    );
  }
}
