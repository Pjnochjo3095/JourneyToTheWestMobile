import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journey_to_west/models/User.dart';
import 'package:journey_to_west/repos/UserRepository.dart';
import 'package:journey_to_west/views/home/home_screen.dart';

import 'package:scoped_model/scoped_model.dart';

import 'HomeViewModel.dart';

class LoginViewModel extends Model {
  String username, password;

  void onChange(String tagret, String value) {
    switch (tagret) {
      case "username":
        this.username = value;
        break;
      case "password":
        this.password = value;
        break;
    }
    notifyListeners();
  }

  void clickToLogin(BuildContext context) async {
    if(username != null && password != null){
      UserLoginModel model = UserLoginModel(this.username, this.password);
      UserRepository userRepository = UserRepositoryImp();
      if (await userRepository.login(model) != null) {
        await SystemChannels.textInput.invokeMethod('TextInput.hide');
        Navigator.of(context).pop();
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(model:HomeViewModel(),)));
      }
    }else{
      Fluttertoast.showToast(
          msg: "Please input all",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0);
    }


  }
}
