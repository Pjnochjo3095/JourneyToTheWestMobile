import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';
class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    Key key, this.child,
  }) : super(key: key);
  final Widget child;



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.8,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(29),
        boxShadow: [
            BoxShadow(
                color: kPrimaryColor,
                offset: Offset(0.0, 10.0),
                blurRadius: 15.0),
        ],
      ),
      child: child,
    );
  }
}