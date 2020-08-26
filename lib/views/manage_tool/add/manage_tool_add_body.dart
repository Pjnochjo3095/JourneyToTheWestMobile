import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/component/round_btn.dart';
import 'package:journey_to_west/views/tool/component/tool_background.dart';
import 'package:scoped_model/scoped_model.dart';

class ManageToolAddBody extends StatelessWidget {
  String id;

  ManageToolAddBody({this.id});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant<SceneViewModel>(
      builder: (context, child, model) {
        model.toolModel.fetchTool();
        if (model.toolModel.listTool.length > 0) {
          return Scaffold(
              extendBody: true,
              appBar: AppBar(
                title: Text(
                  "Add Tool To Scene",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                backgroundColor: ToolColor.primaryColor,
              ),
              body: ToolBackground(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: size.width,
                          alignment: Alignment.center,
                          child: Text(
                            "Borrow Tool Form",
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
                            leading:
                                Icon(Icons.title, color: ToolColor.activeColor),
                            title: DropDownTool()),
                        ListTile(
                          leading: Icon(Icons.rate_review,
                              color: ToolColor.activeColor),
                          title: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              model.changeText("amount", value);
                            },
                            decoration: InputDecoration(
                                hintText: "Amount",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12.0),
                                border: InputBorder.none),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.date_range,
                              color: ToolColor.activeColor),
                          title: FlatButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    theme: DatePickerTheme(
                                      headerColor: kPrimaryColor,
                                      backgroundColor: kBackgroundColor,
                                      itemStyle: TextStyle(
                                          color: kTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      doneStyle: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ), onConfirm: (date) {
                                  model.setTime("refundDay", date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Text(model.refundDay != null
                                  ? model.refundDay
                                      .toString()
                                      .split(" ")[0]
                                      .toString()
                                  : "Choice Refund Date")),
                        ),
                        RoundBtn(
                          title: "Add Tool",
                          press: () {
                            model.addTool(context);
                          },
                          color: ToolColor.primaryColor,
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
      },
    );
  }
}

class DropDownTool extends StatefulWidget {
  @override
  _DropDownToolState createState() => _DropDownToolState();
}

class _DropDownToolState extends State<DropDownTool> {
  String isSelect;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SceneViewModel>(
      builder: (context, child, model) {
        model.listName.clear();
        model.toolModel.listTool.forEach((element) {
          model.listName.add(element.name + ":" + element.amount.toString());
        });
        if (model.listName != null && model.toolModel.listTool != null) {
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
                model.changeIdOfTool(
                    model.toolModel.listTool[model.listName.indexOf(value)].id);
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
