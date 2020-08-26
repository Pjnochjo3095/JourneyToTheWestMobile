import 'package:flutter/material.dart';
import 'package:journey_to_west/view_models/LoginViewModel.dart';
import 'package:journey_to_west/views/login/sign_in/login_body.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  LoginViewModel model;
  LoginScreen(this.model);
  @override
  Widget build(BuildContext context) {
    return ScopedModel<LoginViewModel>(
      model: model,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Background(),
      ),
    );
  }
}

