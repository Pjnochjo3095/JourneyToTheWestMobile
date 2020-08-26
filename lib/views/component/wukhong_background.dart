import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journey_to_west/helpers/Constant.dart';
class WukongBackground extends StatelessWidget {
  const WukongBackground({
    Key key,
    @required this.child,
  }) : super(key: key);
  final Widget child;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 20,
            right: -50,
            child: SvgPicture.asset(
              "assets/images/wukong2.svg",
              width: size.width * 0.5,
              color: kTextColor.withOpacity(0.3),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            child: SvgPicture.asset(
              "assets/images/wukong3.svg",
              width: size.width * 0.5,
              color: kTextColor.withOpacity(0.3),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SvgPicture.asset(
              "assets/images/wukong4.svg",
              width: size.width * 0.5,
              color: kTextColor.withOpacity(0.3),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            child: SvgPicture.asset(
              "assets/images/wukong1.svg",
              width: size.width * 0.5,
              color: kTextColor.withOpacity(0.3),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
