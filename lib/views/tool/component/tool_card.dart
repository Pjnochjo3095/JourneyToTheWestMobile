import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/models/Tool.dart';
import 'package:journey_to_west/view_models/ToolViewModel.dart';
import 'package:journey_to_west/views/tool/detail/tool_detail_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class ToolCard extends StatelessWidget {
  const ToolCard({
    Key key,
    this.itemIndex,
    this.tool,
  }) : super(key: key);
  final int itemIndex;
  final Tool tool;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant<ToolViewModel>(
      builder: (context, child, model) {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          height: 120,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                return ToolDetailScreen(model: model,id: tool.id,);
                },
              ));
            },
            child: Stack(
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: itemIndex % 2 == 0
                          ? ToolColor.layoutColor
                          : ToolColor.secondaryBackgroundColor,
                      boxShadow: [kDefaultShadow]),
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22)),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Container(
                        width: size.width * 0.45,
                        child: Text(
                          tool.name,
                          style: TextStyle(color: kTextColor, fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02,),
                      Container(
                        width: size.width * 0.2,
                        height: size.height * 0.03,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                            color: tool.status == StatusTool.AVAILABLE
                                ? Colors.green
                                : tool.status == StatusTool.DELETED
                                    ? Colors.red
                                    : Colors.blue),
                        child: Text(tool.status),
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 30,
                  top: 10 ,
                  child: Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(tool.image != null
                                    ? tool.image
                                    : "https://i.picsum.photos/id/9/250/250.jpg?hmac=tqDH5wEWHDN76mBIWEPzg1in6egMl49qZeguSaH9_VI"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [kDefaultShadow]),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
