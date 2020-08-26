import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journey_to_west/helpers/Constant.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key, this.onChanged,
  }) : super(key: key);
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 4),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.4),borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          icon: SvgPicture.asset("assets/icons/search.svg",color: kTextColor,),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search",
          hintStyle:TextStyle(color: Colors.grey, fontSize: 12.0),
        ),
      ),
    );
  }
}