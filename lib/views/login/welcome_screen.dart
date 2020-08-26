import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/LoginViewModel.dart';
import 'package:journey_to_west/view_models/SignUpViewModel.dart';
import 'package:journey_to_west/views/Component/round_btn.dart';

import 'package:journey_to_west/views/login/sign_in/login_screen.dart';
import 'package:journey_to_west/views/login/sign_up/sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  LoginViewModel model;
  SignUpViewModel model2;
  WelcomeScreen(this.model, this.model2);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/silhouette-of-mountain-2088210.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: kDefaultPadding * 5),
                child: SvgPicture.asset(
                  "assets/images/wukong1.svg",
                  width: size.width * 0.5,
                  color: kTextColor.withOpacity(0.45),
                ),
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              RoundBtn(
                title: "LOGIN",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen(model);
                  }));
                },
              ),
              RoundBtn(
                title: "SIGN UP",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUpScreen(model2);
                  }));
                },
                color: kBackgroundBehindColor,
                textColor: kTextColor,
              ),
              SvgPicture.asset(
                "assets/images/wukong2.svg",
                width: size.width * 0.5,
                color: kTextColor.withOpacity(0.45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
