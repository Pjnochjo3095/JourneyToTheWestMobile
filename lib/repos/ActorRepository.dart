import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/models/Actor.dart';
import 'package:journey_to_west/models/Scene.dart';


abstract class ActorRepository {
  Future<List<Actor>> fetchActor();

  Future<Actor> getActorById(String id);

  Future<bool> enableActor(String id);

  Future<bool> create(ActorUpdateModel model, String id);

  Future<bool> update(ActorUpdateModel model, String id);

  Future<List<String>> getRoles();

  Future<List<CharacterModel>> fetchCharacter(String id);

  Future<List<SceneView>> fetchScenes(String id);

  Future<List<SceneView>> fetchScenesInHistory(String id);
}

class ActorRepositoryImp with ActorRepository {
  @override
  Future<bool> enableActor(String id) async {
    final response = await http
        .put(ActorAPI.ENABlE_ACTOR_BY_ID + id, headers: <String, String>{
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
  Future<Actor> getActorById(String id) async {
    var response = await http.get(ActorAPI.GET_ACTOR_BY_ID + id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (response.statusCode == 200) {
      return Actor.fromJson(json.decode(response.body));
    } else {
      throw Exception("Not Found");
    }
  }

  @override
  Future<List<Actor>> fetchActor() async {
    final response = await http.get(ActorAPI.FETCH_LIST_ACTOR,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (response.statusCode == 200) {
      List<dynamic> listTemp = json.decode(response.body);
      List<Actor> listActor = new List<Actor>();
      if (listTemp != null) {
        for (var elm in listTemp) {
          var map = elm as Map<String, dynamic>;
          listActor.add(Actor.fromJson(map));
        }
        return listActor;
      } else {
        throw Exception("Error List Actor is Null");
      }
    } else {
      throw Exception("Error");
    }
  }

  @override
  Future<bool> update(ActorUpdateModel model, String id) async {
    Dio dio = Dio();
    FormData data = new FormData.fromMap({
      "Name": model.name,
      "Description": model.desc,
      "Image": model.avatar,
      "Phone": model.phone,
      "Email": model.email
    });

    var response = await dio.put(ActorAPI.UPDATE_ACTOR + id, data: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Status " + response.statusCode.toString());
    }
  }

  @override
  Future<bool> create(ActorUpdateModel model, String id) async {
    Dio dio = Dio();

    FormData data = new FormData.fromMap({
      "Id": id,
      "Name": model.name,
      "Description": model.desc,
      "Image": model.avatar,
      "Phone": model.phone,
      "Email": model.email
    });
    var response = await dio.post(ActorAPI.CREATE_ACTOR, data: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Status " + response.statusCode.toString());
    }
  }

  static const _chars =
      "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890";
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Future<List<String>> getRoles() async {
    final response = await http.get(ActorAPI.GET_ROLES,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (response.statusCode == 200) {
      if (response.body != null) {
        List<dynamic> listTemp = json.decode(response.body);
        List<String> listRoles = new List<String>();
        if (listTemp != null) {
          for (var elm in listTemp) {
            listRoles.add(elm);
          }
          return listRoles;
        } else {
          throw Exception("List Roles is Null");
        }
      }
    } else {
      throw Exception("Not Found");
    }
  }

  @override
  Future<List<CharacterModel>> fetchCharacter(String id) async {
    final response = await http.get(ActorAPI.FETCH_CHARACTERS+id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (response.statusCode == 200) {
      List<dynamic> listTemp = json.decode(response.body);
      List<CharacterModel> listCharacter = new List<CharacterModel>();
      if (listTemp != null) {
        for (var elm in listTemp) {
          var map = elm as Map<String, dynamic>;
          listCharacter.add(CharacterModel.fromJson(map));
        }
        return listCharacter;
      } else {
        throw Exception("Error List Character is Null");
      }
    } else {
      throw Exception("Error");
    }
  }

  @override
  Future<List<SceneView>> fetchScenes(String id) async {
    final response = await http.get(ActorAPI.FETCH_SCENES+id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (response.statusCode == 200) {
      List<dynamic> listTemp = json.decode(response.body);
      List<SceneView> listScene = new List<SceneView>();
      if (listTemp != null) {
        for (var elm in listTemp) {
          var map = elm as Map<String, dynamic>;
          listScene.add(SceneView.fromJson(map));
        }
        return listScene;
      } else {
        throw Exception("Error List Scene is Null");
      }
    } else {
      throw Exception("Error");
    }
  }

  @override
  Future<List<SceneView>> fetchScenesInHistory(String id) async {
    final response = await http.get(ActorAPI.FETCH_SCENES_DONE+id,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        });
    if (response.statusCode == 200) {
      List<dynamic> listTemp = json.decode(response.body);
      List<SceneView> listScene = new List<SceneView>();
      if (listTemp != null) {
        for (var elm in listTemp) {
          var map = elm as Map<String, dynamic>;
          listScene.add(SceneView.fromJson(map));
        }
        return listScene;
      } else {
        throw Exception("Error List Scene is Null");
      }
    } else {
      throw Exception("Error");
    }
  }
}
