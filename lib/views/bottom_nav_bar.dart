import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journey_to_west/helpers/Constant.dart';

class BottonNavBar extends StatelessWidget {
  const BottonNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            press: (){},
            svgSrc: "assets/icons/calendar.svg",
            title: "History",
            isActive: false,
          ),
          BottomNavItem(
            press: (){},
            svgSrc: "assets/icons/user-icon.svg",
            title: "Information",
            isActive: false,
          ),
          BottomNavItem(
            press: (){},
            svgSrc: "assets/icons/Settings.svg",
            title: "Setting",
            isActive: true,
          ),
        ],
      ),
    );
  }
}
class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    Key key, this.svgSrc, this.title,this.press, this.isActive
  }) : super(key: key);
  final String svgSrc;
  final String title;
  final Function press;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(svgSrc, color: isActive ? kActiveIconColor : kTextColor, height: 30, width: 30,),
          Text(
            title, style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
          )
        ],
      ),
    );
  }
}