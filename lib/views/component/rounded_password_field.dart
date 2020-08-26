import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({
    Key key, this.onChanged, this.title, this.isSignIn
  }) : super(key: key);
  final ValueChanged<String> onChanged;
  final String title;
  final bool isSignIn;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: isSignIn ?Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ): Icon(null),
          border: InputBorder.none
      ),
    );
  }
}