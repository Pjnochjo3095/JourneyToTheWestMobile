import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journey_to_west/helpers/Constant.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    this.svgSrc,
    this.title,
    this.press,
    this.color1,
    this.color2
  }) : super(key: key);
  final String svgSrc;
  final String title;
  final Function press;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        width: size.width * 0.4,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,tileMode: TileMode.clamp,
                colors: [color1.withOpacity(0.8), color2.withOpacity(0.5)]),
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
             kDefaultShadow
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: <Widget>[
                  SvgPicture.asset(
                    svgSrc,
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(height: size.height * 0.03,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.title.copyWith(
                            color: kTextColor,
                            letterSpacing: .6,
                            fontFamily: "Poppins-Medium",
                          ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
