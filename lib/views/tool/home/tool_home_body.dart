import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/ToolViewModel.dart';
import 'package:journey_to_west/views/component/search_box.dart';
import 'package:journey_to_west/views/tool/component/tool_background.dart';
import 'package:journey_to_west/views/tool/component/tool_card.dart';
import 'package:journey_to_west/views/tool/create/tool_create_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolHomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ToolViewModel>(
      builder: (context, child, model) {
        if (!model.isFetch) {
          model.fetchTool();
        }
        if (model.listTool != null) {
          return Scaffold(
            backgroundColor: ToolColor.secondaryBackgroundColor,
            appBar: AppBar(
              backgroundColor: ToolColor.primaryColor,
              elevation: 0,
              title: Text(
                "Tool",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 28),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ToolCreateScreen(
                            model: model,
                          )));
              },
              backgroundColor: ToolColor.primaryColor,
              child: Icon(Icons.add),
            ),
            body: ToolBackground(
                child: Column(
              children: <Widget>[
                SizedBox(height: 40,),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      "List Tool",
                      style: TextStyle(color: kTextColor, fontSize: 24),
                    )),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: kBackgroundColor.withOpacity(0.6),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(40)),
                        ),
                      ),

                      ListView.builder(
                        itemBuilder: (context, index) => ToolCard(itemIndex: index,tool: model.listTool[index]),
                        itemCount: model.listTool.length,
                      )
                    ],
                  ),
                )
              ],
            )),
          );
        }
        return Container();
      },
    );
  }
}
