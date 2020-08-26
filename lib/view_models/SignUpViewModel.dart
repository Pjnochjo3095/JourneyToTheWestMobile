import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/models/User.dart';
import 'package:journey_to_west/repos/UserRepository.dart';
import 'package:journey_to_west/views/login/sign_in/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'LoginViewModel.dart';

class SignUpViewModel extends Model {
  String username, password, confirm;
  bool result = false;

  void changeText(String type, String value) {
    switch (type) {
      case "username":
        username = value;
        break;
      case "password":
        password = value;
        break;
      case "confirm":
        confirm = value;
        break;
    }
  }


  void signUpAccount(BuildContext context) {
    UserRepository repo = UserRepositoryImp();
    if(username != null && password != null && confirm != null){
      UserRegisterModel model = UserRegisterModel(username, password, confirm);
      repo.registerAccount(model).then((value) {
        if (value == StatusCreate.DONE) {
          result = true;
          Fluttertoast.showToast(
              msg: "Create Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);
          Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginScreen(LoginViewModel());
          }));
          notifyListeners();
        } else if (value == StatusCreate.FAIL) {
          Fluttertoast.showToast(
              msg: "Create Fail",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Password not matching",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);
        }
      });
    }
    else{
      Fluttertoast.showToast(
          msg: "Please input all",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0);
    }

  }
}
