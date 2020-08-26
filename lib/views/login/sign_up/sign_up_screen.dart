import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/SignUpViewModel.dart';
import 'package:journey_to_west/views/login/sign_up/sign_up_body.dart';
import 'package:scoped_model/scoped_model.dart';
class SignUpScreen extends StatelessWidget {
  @override
  SignUpViewModel model;
  SignUpScreen(this.model);
  Widget build(BuildContext context) {
    return ScopedModel<SignUpViewModel>(
      model: model,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SignUpBody(),
      ),
    );
  }
}
