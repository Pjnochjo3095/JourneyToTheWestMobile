import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/SceneViewModel.dart';
import 'package:journey_to_west/views/component/drop_down_list.dart';
import 'package:journey_to_west/views/component/search_box.dart';
import 'package:journey_to_west/views/manage_tool/add/manage_tool_add_screen.dart';
import 'package:journey_to_west/views/tool/component/tool_background.dart';
import 'package:scoped_model/scoped_model.dart';

class ManageToolHomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return ScopedModelDescendant<SceneViewModel>(
      builder: (context, child, model) {
        if (!model.isChange) {
          model.fetchScene();
        }
        if (model.listScene.length > 0) {
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              backgroundColor: ToolColor.primaryColor,
              title: Text(
                "Manage Tool",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            body: ToolBackground(
              child: Container(
                width: size.width,
                height: size.height,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: size.width,
                      height: size.height * 0.1,
                      child: Text(
                        "All tool of Scene",
                        style: TextStyle(fontSize: 24),
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                        width: size.width,
                        height: size.height * 0.12,
                        child: DropDownList()),
                    Expanded(
                      child: Container(
                        width: size.width,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Tool Box",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: kTextColor),
                            ),
                            model.listTools.length == 0
                                ? Expanded(
                              child: Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "This scene don't have any tool",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 30),
                                    )),
                              ),
                            )
                                : Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                child: ListView.builder(
                                    itemCount: model.listTools.length,
                                    itemBuilder: (context, index) =>
                                        Container(
                                          width: size.width,
                                          height: 120,
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    color: index % 2 == 0
                                                        ? ToolColor
                                                        .layoutColor
                                                        : ToolColor
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
                                                          .circular(
                                                          22)),
                                                ),
                                              ),
                                              Positioned(
                                                left: 10,
                                                top: 10,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    Container(
                                                      width:
                                                      size.width * 0.45,
                                                      child: Text(
                                                        model
                                                            .listTools[
                                                        index]
                                                            .name,
                                                        style: TextStyle(
                                                            color:
                                                            kTextColor,
                                                            fontSize: 20),
                                                        textAlign:
                                                        TextAlign.left,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                      size.width * 0.45,
                                                      height: size.height *
                                                          0.04,
                                                      alignment:
                                                      Alignment.center,
                                                      decoration:
                                                      BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            23),
                                                      ),
                                                      child: ListTile(
                                                        title: Text(
                                                            "From: " + model
                                                                .listTools[
                                                            index]
                                                                .borrowFrom
                                                                .split("T")[0]),
                                                        subtitle: Text(
                                                            "To: " + model
                                                                .listTools[
                                                            index]
                                                                .borrowTo
                                                                .split("T")[0]),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                right: 50,
                                                top: 10,
                                                child: Container(
                                                    width: 80,
                                                    height: 80,
                                                    alignment:
                                                    Alignment.center,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  model
                                                                      .listTools[index]
                                                                      .image !=
                                                                      null
                                                                      ? model
                                                                      .listTools[index]
                                                                      .image
                                                                      : "https://i.picsum.photos/id/9/250/250.jpg?hmac=tqDH5wEWHDN76mBIWEPzg1in6egMl49qZeguSaH9_VI"),
                                                              fit: BoxFit.cover),
                                                          borderRadius: BorderRadius
                                                              .circular(35),
                                                          boxShadow: [
                                                            kDefaultShadow
                                                          ]),
                                                    )),
                                              ),
                                              Positioned(
                                                left: size.width * 0.36,
                                                top: 18,
                                                child: Container(
                                                  width: 100,
                                                  height: 90,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(45),
                                                    border: Border.all(
                                                        color: kTextColor
                                                            .withOpacity(
                                                            0.1),
                                                        style: BorderStyle
                                                            .solid,
                                                        width: 0.2),
                                                  ),
                                                  child: ListTile(
                                                    title: Text("Amount"),
                                                    subtitle: Center(child: Text(
                                                      model.listTools[index]
                                                          .amount.toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          fontSize: 18),)),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 10,
                                                child: model.listTools[index]
                                                    .status == StatusOrder.NEW
                                                    ? Container(
                                                  width: 25,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(23),
                                                      boxShadow: [kDefaultShadow]
                                                  ),
                                                  child: InkWell(
                                                    child: SvgPicture.asset(
                                                      "assets/icons/002-dustbin.svg",
                                                      color: kTextColor,),
                                                    onTap: () {
                                                      model.deleteOrder(
                                                          model.listTools[index]
                                                              .id, context);
                                                    },
                                                  ),
                                                )
                                                    : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10),
                                                  width: 25,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(23),
                                                      boxShadow: [kDefaultShadow],
                                                      color: Colors.red
                                                  ),

                                                  child: Text(
                                                    model.listTools[index].status,
                                                    style: TextStyle(
                                                        fontSize: 18),),
                                                ),
                                              ),
                                            ],
                                          ),
                                          margin:
                                          EdgeInsets.only(bottom: 20),
                                        )),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: model.idForAddTool  != null ?FloatingActionButton(
              onPressed: () {
                if (model.idForAddTool != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ManageToolAddScreen(
                            model: model,id: model.idForAddTool,
                          )));
              }
              },
              backgroundColor: ToolColor.primaryColor,
              child: Icon(Icons.add),

            ) : Container(),
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
