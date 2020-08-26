import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/models/Scene.dart';
import 'package:journey_to_west/models/Tool.dart';


abstract class SceneRepository {
  Future<List<Scene>> fetchScene();

  Future<Scene> getById(String id);

  Future<bool> createScene(SceneCreateModel model);

  Future<bool> updateScene(SceneUpdateModel model);

  Future<bool> deleteScene(String id);

  Future<List<CharacterViewModel>> fetchCharacters(String id);

  Future<List<ToolOrderViewModel>> fetchTools(String id);

  Future<bool> finishScene(String id);

  Future<bool> addCharacter(CharacterCreateModel model);

  Future<bool> updateCharacter(CharacterUpdateModel model, String id);

  Future<bool> getCharacterById(String id);

  Future<bool> deleteCharacter(String id);

  Future<bool> addTool(OrderToolCreateModel model, String id, String author);

  Future<bool> deleteTool(String id);

  Future<List<ToolOrderViewModel>> fetchAllOrder(String begin, String end);
}

class SceneRepositoryImp with SceneRepository {
  @override
  Future<bool> createScene(SceneCreateModel model) async {
    var response = await http.post(SceneAPI.CREATE_SCENE,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode(<String, dynamic>{
          "name": model.name.toString(),
          "description": model.desc.toString(),
          "location": model.location.toString(),
          "time_start": model.begin.toIso8601String(),
          "time_end": model.end.toIso8601String(),
          "snapshot": model.snapshot
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Status code is: " + response.statusCode.toString());
    }
  }

  @override
  Future<bool> deleteScene(String id) async {
    var response = await http.delete(SceneAPI.DELETE_SCENE + id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Status " + response.statusCode.toString());
    }
  }

  @override
  Future<List<Scene>> fetchScene() async {
    final respone = await http.get(SceneAPI.FETCH_LIST_SCENE,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (respone.statusCode == 200) {
      List<dynamic> listTempt = json.decode(respone.body);
      List<Scene> result = new List<Scene>();
      if (listTempt != null) {
        for (var tempt in listTempt) {
          var map = tempt as Map<String, dynamic>;
          result.add(Scene.fromJson(map));
        }
        return result;
      } else {
        throw Exception("Fetch Film Error");
      }
    } else {
      throw Exception("Status " + respone.statusCode.toString());
    }
  }

  @override
  Future<Scene> getById(String id) async {
    var response = await http.get(SceneAPI.GET_BY_ID + id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (response.statusCode == 200) {
      return Scene.fromJson(json.decode(response.body));
    } else {
      throw Exception("Status " + response.statusCode.toString());
    }
  }

  @override
  Future<bool> updateScene(SceneUpdateModel model) async {
    var response = await http.put(SceneAPI.UPDATE_SCENE + model.id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode(<String, dynamic>{
          "name": model.name,
          "description": model.desc,
          "location": model.location,
          "time_start": model.begin.toIso8601String(),
          "time_end": model.end.toIso8601String(),
          "snapshot": model.snapshot
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Status " + response.statusCode.toString());
    }
  }

  @override
  Future<List<CharacterViewModel>> fetchCharacters(String id) async {
    final respone = await http.get(SceneAPI.FETCH_CHARACTERS + id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (respone.statusCode == 200) {
      List<dynamic> listTempt = json.decode(respone.body);
      List<CharacterViewModel> result = new List<CharacterViewModel>();
      if (listTempt != null) {
        for (var tempt in listTempt) {
          var map = tempt as Map<String, dynamic>;
          result.add(CharacterViewModel.fromJson(map));
        }
        return result;
      } else {
        throw Exception("Fetch Character error");
      }
    } else {
      throw Exception("Status " + respone.statusCode.toString());
    }
  }

  @override
  Future<List<ToolOrderViewModel>> fetchTools(String id) async {
    final respone = await http.get(SceneAPI.FETCH_TOOLS + id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (respone.statusCode == 200) {
      List<dynamic> listTempt = json.decode(respone.body);
      List<ToolOrderViewModel> result = new List<ToolOrderViewModel>();
      if (listTempt != null) {
        for (var tempt in listTempt) {
          var map = tempt as Map<String, dynamic>;
          result.add(ToolOrderViewModel.fromJson(map));
        }
        return result;
      } else {
        throw Exception("Fetch Tool Error");
      }
    } else {
      throw Exception("Status " + respone.statusCode.toString());
    }
  }

  @override
  Future<bool> finishScene(String id) async {
    var response = await http.put(SceneAPI.FINISH_SCENE + id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Status " + response.statusCode.toString());
    }
  }

  @override
  Future<bool> addCharacter(CharacterCreateModel model) async {
    print(model.sceneId);
    print(model.actorId);
    print(model.character);
    print(model.characterScript);
    print(model.description);
    final response = await http.post(SceneAPI.ADD_CHARACTER_OF_SCENE,headers: <String, String>{
      "accept": "application/json",
      "Content-Type": "application/json; charset=UTF-8"
    },
        body: json.encode(<String, dynamic>{
          "sceneid" : model.sceneId,
          "actorid" : model.actorId,
          "description": model.description,
          "character" : model.character,
          "script-link": model.characterScript
        }));
    if( response.statusCode == 200){
      return true;
    }else{
//      return false;
      throw Exception("Status "+ response.statusCode.toString());
    }
  }

  @override
  Future<bool> updateCharacter(CharacterUpdateModel model, String id) {
    // TODO: implement updateCharacter
    throw UnimplementedError();
  }
  @override
  Future<bool> deleteCharacter(String id) async {
    final response = await http.delete(SceneAPI.DELETE_CHARACTER_OF_SCENE + id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if(response.statusCode == 200){
      return true;
    }else{
      throw Exception("Error"+ response.statusCode.toString());
    }
  }
  @override
  Future<bool> deleteTool(String id) async {
    final response = await http.delete(SceneAPI.DELETE_TOOL_OF_SCENE + id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if(response.statusCode == 200){
      return true;
    }else{
      throw Exception("Error"+ response.statusCode.toString());
    }
  }

  @override
  Future<bool> addTool(OrderToolCreateModel model, String id, String author) async {
    final response = await http.post(SceneAPI.ADD_TOOL_OF_SCENE,headers: <String, String>{
      "accept": "application/json",
      "Content-Type": "application/json; charset=UTF-8"
    },
      body: json.encode(<String, dynamic>{
        "sceneid" : id,
        "author" : author,
        "tools": [
          {
            "toolid": model.toolid,
            "borrow-from": model.borrowFrom.toIso8601String(),
            "borrow-to" : model.borrowTo.toIso8601String(),
            "amount" : model.amount
          }
        ]
      }));
    if( response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  @override
  Future<bool> getCharacterById(String id) async {
    // TODO: implement fetchAllOrder
    throw UnimplementedError();
  }

  @override
  Future<List<ToolOrderViewModel>> fetchAllOrder(String begin, String end) async {
    String url = "BorrowFrom=" + begin + "&" + "BorrowTo=" +end;
    print(SceneAPI.GET_ALL_ORDER+url);
    final response = await http.get(SceneAPI.GET_ALL_ORDER+url,
    headers: <String, String>{
      "accept": "application/json",
      "Content-Type": "application/json; charset=UTF-8"
    },
    );
    if (response.statusCode == 200) {
      List<dynamic> listTempt = json.decode(response.body);
      List<ToolOrderViewModel> result = new List<ToolOrderViewModel>();
      if (listTempt != null) {
        for (var tempt in listTempt) {
          var map = tempt as Map<String, dynamic>;
          result.add(ToolOrderViewModel.fromJson(map));
        }
        return result;
      } else {
        throw Exception("Fetch Tool Error");
      }
    } else {
      throw Exception("Status " + response.statusCode.toString());
    }
  }




}
