import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/models/Tool.dart';
abstract class ToolRepository {
  Future<List<Tool>> fetchTool();

  Future<bool> create(ToolCreateModel model);

  Future<Tool> getById(String id);

  Future<bool> delete(String id);

  Future<bool> update(ToolUpdateModel model, String id);
}

const _chars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890";
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class ToolRepositoryImp with ToolRepository {
  @override
  Future<bool> create(ToolCreateModel model) async {
    Dio dio = Dio();

    FormData data = new FormData.fromMap({
      "Name": model.name,
      "Amount": model.amount,
      "Image": model.image,
      "Description": model.description
    });
    var response = await dio.post(ToolAPI.CREATE_TOOL, data: data);
    if(response.statusCode == 200){
      return true;
    }else{
      throw Exception("Status " + response.statusCode.toString());
    }
  }

  @override
  Future<bool> delete(String id) async {
    var response = await http.delete(ToolAPI.DELETE_TOOL + id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Status code is : " + response.statusCode.toString());
    }
  }

  @override
  Future<List<Tool>> fetchTool() async {
    var response = await http.get(ToolAPI.FETCH_LIST_TOOL,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (response.statusCode == 200) {
      List<dynamic> temps = json.decode(response.body);
      List<Tool> listTool = List();
      for (var temp in temps) {
        var map = temp as Map<String, dynamic>;
        listTool.add(Tool.fromJson(map));
      }
      return listTool;
    } else {
      throw Exception("Status " + response.statusCode.toString());
    }
  }

  @override
  Future<Tool> getById(String id) async {
    if (id != null) {
      var response = await http.get(ToolAPI.GET_BY_ID + id,
          headers: <String, String>{
            "accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8"
          });
      if (response.statusCode == 200) {
        return Tool.fromJson(json.decode(response.body));
      } else {
        throw Exception("Status " + response.statusCode.toString());
      }

    }
  }

  @override
  Future<bool> update(ToolUpdateModel model, String id) async {
    Dio dio = Dio();
    FormData data = new FormData.fromMap({
      "Name": model.name,
      "Amount": model.amount,
      "Image": model.image,
      "Description": model.description
    });

    var response = await dio.put(ToolAPI.UPDATE_TOOL+id, data: data);
    if(response.statusCode == 200){
      return true;
    }
    else{
      throw Exception("Status " + response.statusCode.toString());
    }

  }

}
