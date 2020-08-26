import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {
  Future<User> fetchUser(String token);

  Future<String> login(UserLoginModel model);

  Future<String> registerAccount(UserRegisterModel model);

  Future<bool> removeRoleAdmin(String id);

  Future<bool> addRoleAdmin(String id);

  Future<bool> removeRoleUser(String id);

  Future<bool> addRoleUser(String id);
}

class UserRepositoryImp with UserRepository {
  http.Client client = new http.Client();

  @override
  Future<User> fetchUser(String token) async{
    final http.Response  response = await client.get(UserAPI.FETCH_USER,
        headers: <String, String>{
          'accept': 'application/json',
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer " + token
        } );
    if (response.statusCode == 200){
      return User.fromJson(json.decode(response.body));
    }else{
      throw Exception("Invalid Token");
    }
  }

  @override
  Future<String> login(UserLoginModel model) async {
    final http.Response response = await client.post(UserAPI.LOGIN,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode(<String, String>{
          "username": model.username,
          "password": model.password
        }));
    if (response.statusCode == 200) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.remove("token");
      sharedPreferences.setString("token", json.decode(response.body));
      return response.body;
    } else {
      throw Exception("Username or Password invalid");
    }
  }

  @override
  Future<String> registerAccount(UserRegisterModel model) async {
    if(model.password != model.confirm){
      return StatusCreate.ERROR;
    }
    final http.Response response = await http.post(UserAPI.REGISTER_ACCOUNT,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode(<String, String>{
          "username": model.username,
          "password": model.password,
          "confirm": model.confirm
        }));
    if(response.statusCode == 200){
      return StatusCreate.DONE;
    }else{
      return StatusCreate.FAIL;
    }
  }

  @override
  Future<bool> addRoleAdmin(String id) async {
    final response = await http.put(UserAPI.ADD_ROLE_ADMIN + id, headers: <String, String>{
      'accept': 'application/json',
      "Content-Type": "application/json; charset=UTF-8",
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Change Fail");
    }
  }

  @override
  Future<bool> addRoleUser(String id) async {
    final response = await http.put(UserAPI.ADD_ROLE_USER + id, headers: <String, String>{
      'accept': 'application/json',
      "Content-Type": "application/json; charset=UTF-8",
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Change Fail");
    }
  }

  @override
  Future<bool> removeRoleAdmin(String id) async {
    final response = await http.delete(UserAPI.DELETE_ROLE_ADMIN + id, headers: <String, String>{
      'accept': 'application/json',
      "Content-Type": "application/json; charset=UTF-8",
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Change Fail");
    }
  }

  @override
  Future<bool> removeRoleUser(String id) async {
    final response = await http.delete(UserAPI.DELETE_ROLE_USER + id, headers: <String, String>{
      'accept': 'application/json',
      "Content-Type": "application/json; charset=UTF-8",
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Change Fail");
    }
  }
}
