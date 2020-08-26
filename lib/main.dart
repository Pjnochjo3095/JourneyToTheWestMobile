
import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/LoginViewModel.dart';
import 'package:journey_to_west/view_models/SignUpViewModel.dart';
import 'package:journey_to_west/views/login/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journey To The West',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: kPrimaryColor
      ),
      home: WelcomeScreen(LoginViewModel(), SignUpViewModel()),
//        home:SceneScreen(SceneViewModel())
    );
  }
}









