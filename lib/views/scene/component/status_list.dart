import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';

class StatusList extends StatefulWidget {
  @override
  _StatusListState createState() => _StatusListState();
}

class _StatusListState extends State<StatusList> {
  int selectedIndex = 0;
  List status = [
    "All",
    StatusScene.NEW,
    StatusScene.PROCESSING,
    StatusScene.DONE,
    StatusScene.DELETE
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: status.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: kDefaultPadding / 2,
                right: index == status.length - 1 ? kDefaultPadding : 0),
            padding:
            EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 5),
            decoration: BoxDecoration(
                color: index == selectedIndex
                    ? Colors.white.withOpacity(0.6)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              status[index],
              style: TextStyle(color: kTextColor),
            ),
          ),
        ),
      ),
    );
  }
}