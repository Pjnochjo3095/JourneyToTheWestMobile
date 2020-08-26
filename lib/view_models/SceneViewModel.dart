import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journey_to_west/models/Scene.dart';
import 'package:journey_to_west/models/Tool.dart';
import 'package:journey_to_west/repos/SceneRepository.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:path/path.dart' as Path;
import 'package:scoped_model/scoped_model.dart';

import 'HomeViewModel.dart';
import 'ToolViewModel.dart';

class SceneViewModel extends Model {
  ToolViewModel toolModel = new ToolViewModel();
  HomeViewModel homeModel = new HomeViewModel();
  ActorViewModel actorModel = new ActorViewModel();
  List<Scene> listScene = new List();
  List<CharacterViewModel> listCharacters = new List();
  List<ToolOrderViewModel> listTools = new List();
  List<String> listName = new List();
  String name, desc, location;
  DateTime begin, end;
  int snapshot;
  bool isChange = false;
  Scene currentScene;
  bool isFetch = false;
  String idForAddTool;
  String idForAddCharacter;
  String toolId;
  String actorId;
  int amount;
  DateTime refundDay;
  String character;
  File scriptLink;
  List<ToolOrderViewModel> listOrder = new List();
  bool isDoneOrder = false;

  void changeText(String type, String value) {
    switch (type) {
      case "name":
        name = value;
        break;
      case "desc":
        desc = value;
        break;
      case "location":
        location = value;
        break;
      case "snapshot":
        snapshot = int.parse(value);
        break;
      case "amount":
        amount = int.parse(value);
        break;
      case "character":
        character = value;
        break;
    }
    notifyListeners();
  }

  void setTime(String type, DateTime value) {
    switch (type) {
      case "begin":
        begin = value;
        break;
      case "end":
        end = value;
        break;
      case "refundDay":
        refundDay = value;
    }
    notifyListeners();
  }

  void fetchScene() {
    SceneRepository sceneRepository = SceneRepositoryImp();
    sceneRepository.fetchScene().then((value) {
      if (value.length > 0) {
        listScene.clear();
        value.forEach((element) {
          listScene.add(element);
          notifyListeners();
        });
      }
      isChange = true;
    });
  }

  void create(BuildContext context) {
    SceneRepository sceneRepository = SceneRepositoryImp();
    if (name != null &&
        desc != null &&
        location != null &&
        begin != null &&
        end != null &&
        snapshot != null) {
      SceneCreateModel model = new SceneCreateModel(this.name, this.desc,
          this.location, this.begin, this.end, this.snapshot);
      if (begin.isBefore(end)) {
        sceneRepository.createScene(model).then((value) {
          if (value) {
            Fluttertoast.showToast(
                msg: "Create Success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                fontSize: 16.0);
            isChange = false;
            listScene.clear();
            Navigator.of(context).pop();
            notifyListeners();
          } else {
            Fluttertoast.showToast(
                msg: "Create Fail",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                fontSize: 16.0);
          }
        });
      } else {
        Fluttertoast.showToast(
            msg: "Please input all",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "invalid end day",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0);
    }
  }

  void delete(String id, BuildContext context) {
    SceneRepository sceneRepository = SceneRepositoryImp();
    sceneRepository.deleteScene(id).then((value) {
      if (value) {
        Fluttertoast.showToast(
            msg: "Delete Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        isChange = false;
        listScene.clear();
        Navigator.of(context).pop();
        notifyListeners();
      } else {
        Fluttertoast.showToast(
            msg: "Delete Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
    });
  }

  void getSceneById(String id) {
    SceneRepository sceneRepository = SceneRepositoryImp();
    sceneRepository.getById(id).then((value) {
      if (value != null) {
        currentScene = value;
        prepareEdit();
      }
      notifyListeners();
    });
  }

  void update(BuildContext context) {
    SceneRepository sceneRepository = SceneRepositoryImp();
    SceneUpdateModel model = SceneUpdateModel(
        id: currentScene.id,
        name: this.name != null ? this.name : this.currentScene.name,
        location:
        this.location != null ? this.location : this.currentScene.location,
        desc: this.desc != null ? this.desc : this.currentScene.desc,
        begin: this.begin != null
            ? this.begin
            : DateTime.parse(this.currentScene.begin),
        end:
        this.end != null ? this.end : DateTime.parse(this.currentScene.end),
        snapshot:
        this.snapshot != null ? this.snapshot : this.currentScene.snapshot);
    if(begin.isBefore(end)){
      sceneRepository.updateScene(model).then((value) {
        if (value) {
          Fluttertoast.showToast(
              msg: "Update Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);
          listScene.clear();
          isChange = false;
          notifyListeners();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else {
          Fluttertoast.showToast(
              msg: "Update Fail",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);
        }
      });
    }else{
      Fluttertoast.showToast(
          msg: "Wrong format day",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0);
    }

  }

  var initName = TextEditingController();
  var initDesc = TextEditingController();
  var initLocation = TextEditingController();
  var initSnapshot = TextEditingController();

  void prepareEdit() {
    initName..text = currentScene.name;
    initDesc..text = currentScene.desc;
    initLocation..text = currentScene.location;
    initSnapshot..text = currentScene.snapshot.toString();
    isChange = false;
  }

  void finish(String id, BuildContext context) {
    SceneRepository sceneRepository = SceneRepositoryImp();
    sceneRepository.finishScene(id).then((value) {
      if (value) {
        Fluttertoast.showToast(
            msg: "Done",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        listScene.clear();
        isChange = false;
        Navigator.of(context).pop();
        notifyListeners();
      } else {
        Fluttertoast.showToast(
            msg: "Not Done",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
    });
  }

  void fetchCharacters(String id) {
    listCharacters.clear();
    SceneRepository sceneRepository = SceneRepositoryImp();
    sceneRepository.fetchCharacters(id).then((value) {
      if (value.length > 0) {
        value.forEach((element) {
          listCharacters.add(element);
          notifyListeners();
        });
      }
      isChange = true;
    });
  }

  void fetchTools(String id) {
    listTools.clear();
    SceneRepository sceneRepository = SceneRepositoryImp();
    sceneRepository.fetchTools(id).then((value) {
      if (value.length > 0) {
        value.forEach((element) {
          listTools.add(element);
          notifyListeners();
        });
      }
    });
  }

  void fetchToolBySelected(String id) {
    fetchTools(id);
    idForAddTool = id;
    notifyListeners();
  }

  void fecthCharacterBySelected(String id) {
    fetchCharacters(id);
    idForAddCharacter = id;
    notifyListeners();
  }

  void changeIdOfTool(String id) {
    toolModel.fetchTool();
    toolId = id;
  }

  void changeIdOfCharacter(String id) {
    actorModel.fetchActors();
    actorId = id;
  }

  void deleteOrder(String id, BuildContext context) {
    SceneRepository sceneRepository = SceneRepositoryImp();
    sceneRepository.deleteTool(id).then((value) {
      if (value) {
        Fluttertoast.showToast(
            msg: "Delete Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        listTools.clear();
        notifyListeners();
        fetchTools(idForAddTool);
      } else {
        Fluttertoast.showToast(
            msg: "Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
    });
  }

  void addTool(BuildContext context) {
    SceneRepository sceneRepository = SceneRepositoryImp();
    if (toolId != null && amount != null && refundDay != null) {
      if (refundDay.isAfter(DateTime.now())) {
        OrderToolCreateModel model = OrderToolCreateModel(
            toolid: toolId,
            amount: amount,
            borrowFrom: DateTime.now(),
            borrowTo: refundDay);
        sceneRepository
            .addTool(model, idForAddTool, homeModel.currentUser.name)
            .then((value) {
          if (value) {
            Fluttertoast.showToast(
                msg: "Add Success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                fontSize: 16.0);
            listTools.clear();
            fetchTools(idForAddTool);
            Navigator.of(context).pop();
          } else {
            Fluttertoast.showToast(
                msg: "Add Fail",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                fontSize: 16.0);
          }
        });
      } else {
        Fluttertoast.showToast(
            msg: "refund day not today",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0);

      }
    } else {
      Fluttertoast.showToast(
          msg: "Please input all",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0);
    }
  }



Future<void> addCharacter(BuildContext context) async {
  SceneRepository sceneRepository = SceneRepositoryImp();
  if (character != null &&
      scriptLink != null &&
      desc != null &&
      actorId != null) {
    String url = await uploadFile(scriptLink);
    CharacterCreateModel model = CharacterCreateModel(
        character: character,
        description: desc,
        sceneId: idForAddCharacter,
        actorId: actorId,
        characterScript: url);
    sceneRepository.addCharacter(model).then((value) {
      if (value) {
        Fluttertoast.showToast(
            msg: "Add Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        listCharacters.clear();
        fetchCharacters(idForAddCharacter);
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: "Add Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
    });
  } else {
    Fluttertoast.showToast(
        msg: "Please input all",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0);
  }
}

Future<String> uploadFile(File file) async {
  StorageReference storageReference = FirebaseStorage.instance
      .ref()
      .child('scripts/' + Path.basename(file.path));
  StorageUploadTask uploadTask = storageReference.putFile(file);
  await uploadTask.onComplete;
  String url = await storageReference.getDownloadURL();
  return url;
}

void deleteCharacter(String id, BuildContext context) {
  SceneRepository sceneRepository = SceneRepositoryImp();
  sceneRepository.deleteCharacter(id).then((value) {
    if (value) {
      Fluttertoast.showToast(
          msg: "Delete Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0);
      listCharacters.clear();
      notifyListeners();
      fetchCharacters(idForAddCharacter);
    } else {
      Fluttertoast.showToast(
          msg: "Fail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0);
    }
  });
}

void getAllOrder() {
  SceneRepository sceneRepository = new SceneRepositoryImp();
  listOrder.clear();
  if (begin != null && end != null) {
    ToolPickdate model = ToolPickdate(
        begin: begin.toIso8601String().split("T")[0],
        end: end.toIso8601String().split("T")[0]);
    sceneRepository.fetchAllOrder(model.begin, model.end).then((value) {
      if (value.length > 0) {
        value.forEach((element) {
          listOrder.add(element);
          notifyListeners();
        });
      }
    });
    notifyListeners();
    isDoneOrder = true;

  }
}}
