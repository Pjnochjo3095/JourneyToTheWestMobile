import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/ToolViewModel.dart';
import 'package:journey_to_west/views/tool/edit/tool_edit_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant<ToolViewModel>(
      builder: (context, child, model) {
        if (model.currentTool != null) {
          if (model.isDone) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: ToolColor.primaryColor,
                  elevation: 0,
                  title: new Text(
                    "Tool",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 32),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) {
                  return ToolEditScreen(model: model,);
                },));
                  },
                  backgroundColor: ToolColor.primaryColor,
                  child: Icon(Icons.edit),
                ),
                body: Container(
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: kDefaultPadding / 2, right: kDefaultPadding / 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: size.width,
                          height: size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: size.width - size.height * 0.2,
                                height: size.width - size.height * 0.2,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: new NetworkImage(
                                        model.currentTool.image != null
                                            ? model.currentTool.image
                                            : "http://kinhteluat.tmu.edu.vn/templates/not-found.png",
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: size.width,
                                height: size.height -
                                    (size.width - size.height * 0.2) -
                                    100,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.05),
                                    border: Border.all(width: 1)),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: size.height * 0.05,),
                                    Text(
                                      model.currentTool.name.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: kTextColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: size.height * 0.09,),
                                    Text(
                                      model.currentTool.description,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: kTextColor,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.06,),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: kDefaultPadding,
                                          bottom: kDefaultPadding,
                                          left: kDefaultPadding * 1.5,
                                          right: kDefaultPadding * 1.5),
                                      decoration: BoxDecoration(
                                          color: model.currentTool.status ==
                                                  StatusTool.OUTOFSTOCK
                                              ? Colors.blue
                                              : model.currentTool.status ==
                                                      StatusTool.DELETED
                                                  ? Colors.red
                                                  : Colors.green,
                                          shape: BoxShape.rectangle,
                                          boxShadow: [kDefaultShadow],
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Text(
                                        model.currentTool.status.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: kTextColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.03,),
                                    ListTile(
                                      title: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Amount",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: kTextColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      subtitle: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          model.currentTool.amount.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: kTextColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }
          return Container(
            color: Colors.white,
          );
        }
        return Container(
          color: Colors.white,
        );
      },
    );
  }
}
