import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journey_to_west/helpers/Constant.dart';

class ToolBackground extends StatelessWidget {
  const ToolBackground({
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
        children: <Widget>[
          Positioned(
            top: 40,
            right: 50,
            child: SvgPicture.asset(
              "assets/images/drone.svg",
              width: size.width * 0.3,
              color: kTextColor.withOpacity(0.2),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SvgPicture.asset(
              "assets/images/classic.svg",
              width: size.width * 0.4,
              color: kTextColor.withOpacity(0.2),
            ),
          ),
          Positioned(
            top: 400,
            right: 20,
            child: SvgPicture.asset(
              "assets/images/classic.svg",
              width: size.width * 0.2,
              color: kTextColor.withOpacity(0.2),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            child: SvgPicture.asset(
              "assets/images/drone.svg",
              width: size.width * 0.2,
              color: kTextColor.withOpacity(0.2),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SvgPicture.asset(
              "assets/images/camera.svg",
              width: size.width * 0.25,
              color: kTextColor.withOpacity(0.2),
            ),
          ),
          Positioned(
            left: 0,
            bottom: size.height/2,
            child: SvgPicture.asset(
              "assets/images/camera.svg",
              width: size.width * 0.2,
              color: kTextColor.withOpacity(0.2),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
