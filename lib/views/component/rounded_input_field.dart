import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
          icon: Icon(icon, color: kPrimaryColor,),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
          border: InputBorder.none
      ),
    );
  }
}