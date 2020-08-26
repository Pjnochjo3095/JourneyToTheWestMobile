import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/LoginViewModel.dart';
import 'package:journey_to_west/view_models/SignUpViewModel.dart';
import 'package:journey_to_west/views/Component/already_have_an_account_check.dart';
import 'package:journey_to_west/views/Component/round_btn.dart';
import 'package:journey_to_west/views/Component/rounded_input_field.dart';
import 'package:journey_to_west/views/Component/rounded_password_field.dart';
import 'package:journey_to_west/views/Component/textfield_container.dart';
import 'package:journey_to_west/views/Component/wukhong_background.dart';
import 'package:journey_to_west/views/login/sign_up/sign_up_screen.dart';

import 'package:scoped_model/scoped_model.dart';

class Background extends StatelessWidget {
  const Background({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant<LoginViewModel>(
        builder: (context, child, model) {

      return new Container(
        child: WukongBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("LOGIN",
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: .6,
                        fontFamily: "Poppins-Medium",
                      )),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Image.asset(
                    "assets/images/login.jpg",
                    height: size.height * .3,
                  ),
                  TextFieldContainer(
                    child: RoundedInputField(
                      hintText: "Your UserName",
                      onChanged: (value) {
                        model.onChange("username", value);
                      },
                    ),
                  ),
                  TextFieldContainer(
                    child: RoundedPasswordField(
                      onChanged: (value) {
                        model.onChange("password", value);
                      },
                      title: "Password",
                      isSignIn: true,
                    ),
                  ),
                  RoundBtn(
                    title: "SIGN IN",
                    press: () {
                      model.clickToLogin(context);
                    },
                    color: kPrimaryColor,
                    textColor: kTextColor,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  AlreadyHaveAnAccountCheck(
                    login: true,
                    press: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUpScreen( SignUpViewModel());
                      }));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
