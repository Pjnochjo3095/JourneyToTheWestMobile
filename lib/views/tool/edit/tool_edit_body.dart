import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/ToolViewModel.dart';
import 'package:journey_to_west/views/component/round_btn.dart';
import 'package:journey_to_west/views/tool/component/tool_background.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolEditBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ToolViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: ToolColor.backgroundColor,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Edit Tool",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32),
            ),
            backgroundColor: ToolColor.primaryColor,
          ),
          body: ToolBackground(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("EDIT TOOL FORM",
                      style: TextStyle(
                        fontSize: 30,
                        letterSpacing: .6,
                        fontFamily: "Poppins-Medium",
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Icon(Icons.title, color: ToolColor.activeColor),
                    title: TextField(
                      controller: model.nameInit,
                      decoration: InputDecoration(
                        hintText: "Your name",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ToolColor.primaryColor),
                        ),
                      ),
                      onChanged: (value) {
                        model.changeText("name", value);
                      },
                    ),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.description, color: ToolColor.activeColor),
                    title: TextField(
                      controller: model.descInit,
                      decoration: InputDecoration(
                        hintText: "Your desciption",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ToolColor.primaryColor),
                        ),
                      ),
                      onChanged: (value) {
                        model.changeText("desc", value);
                      },
                    ),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.rate_review, color: ToolColor.activeColor),
                    title: TextField(
                      controller: model.amountInit,
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
                    leading: FloatingActionButton(
                      onPressed: () {
                        model.pickImage();
                      },
                      backgroundColor: ToolColor.primaryColor,
                      tooltip: 'Pick Image',
                      child: Icon(Icons.add_a_photo),
                    ),
                    title: Center(
                      child: model.image == null
                          ? model.currentTool.image != null ? Image.network(model.currentTool.image) :
                      Text('No image selected.')
                          : Image.file(model.image)

                    ),
                  ),
                  RoundBtn(
                    title: "EDIT TOOL",
                    press: () {
                      model.update(context);
                    },
                    color: ToolColor.primaryColor,
                    textColor: kTextColor,
                  ),
                  RoundBtn(
                    title: "CANCEL",
                    press: () {
                      Navigator.of(context).pop();
                    },
                    color: ToolColor.layoutColor,
                    textColor: kTextColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
