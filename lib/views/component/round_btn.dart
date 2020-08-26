import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';

class RoundBtn extends StatelessWidget {
  const RoundBtn({
    Key key,
    this.title,
    this.color = kPrimaryColor,
    this.press,
    this.textColor = Colors.white,
    this.font = 20

  }) : super(key: key);
  final String title;
  final Color color;
  final Function press;
  final Color textColor;
  final double font;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 13),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding, horizontal: kDefaultPadding * 2),
          color: color,
          onPressed: press,
          child: Container(
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: font,
                letterSpacing: .6,
                fontFamily: "Poppins-Medium",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
