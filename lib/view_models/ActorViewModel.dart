import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_to_west/models/Actor.dart';
import 'package:journey_to_west/models/Scene.dart';
import 'package:journey_to_west/repos/ActorRepository.dart';
import 'package:journey_to_west/repos/UserRepository.dart';
import 'package:path/path.dart' as Path;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActorViewModel extends Model {
  List<Actor> currentListActors = new List<Actor>();
  Actor currentActor;
  String id;
  String name, desc, phone, email;
  bool status;
  File image;
  bool statusInit = false;
  List<String> listRoles = new List<String>();
  List<CharacterModel> characters;
  List<SceneView> listScenes;
  List<SceneView> listSceneIsDone;

  void fetchActors() async {
    ActorRepository actorRepository = new ActorRepositoryImp();
    fetchRoles();
    actorRepository.fetchActor().then((value) {
      if (value != null) {
        currentListActors.clear();
        value.forEach((element) async {
          currentListActors.add(element);
        });
        statusInit = true;
        notifyListeners();
      }
    });
  }
  void fetchCharacters(String id) async{
    ActorRepository actorRepository = new ActorRepositoryImp();
    actorRepository.fetchCharacter(id).then((value){
      if(value != null){
        characters = value;
      }
      notifyListeners();
    });
  }
  void fetchScenes(String id) async{
    ActorRepository actorRepository = new ActorRepositoryImp();
    actorRepository.fetchScenes(id).then((value){
      if(value != null){
        listScenes = value;
      }
      notifyListeners();
    });
  }
  void fetchScenesIsDone(String id) async{
    ActorRepository actorRepository = new ActorRepositoryImp();
    actorRepository.fetchScenesInHistory(id).then((value){
      if(value != null){
        listSceneIsDone = value;
      }
      notifyListeners();
    });
  }
  void fetchRoles() async {
    ActorRepository actorRepository = new ActorRepositoryImp();
    listRoles.clear();
    await actorRepository.getRoles().then((value) {
      if (value != null) {
        value.forEach((element) {
          if (element != "") {
            listRoles.add(element);
          } else {
            listRoles.add("nothing");
          }
        });
      }
    });
  }
  void enableActor(String id, BuildContext context) async {
    ActorRepository actorRepository = new ActorRepositoryImp();
    actorRepository.enableActor(id).then((value) {
      if (value) {
        Fluttertoast.showToast(
            msg: "Change Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        statusInit = false;
        notifyListeners();

//        Navigator.of(context).pop();
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return EnableActorScreen(model: ActorViewModel(),);
//        }));
      }
    });
  }

  void getActorById(String id) {
    ActorRepository actorRepository = new ActorRepositoryImp();
    actorRepository.getActorById(id).then((value) {
      if (value != null) {
        currentActor = value;
        prepareInit();
      }
      notifyListeners();
    });
  }

  Future<void> signOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("token");
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Fluttertoast.showToast(
        msg: "Sign out",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0);
  }

  void pickImage() async {
    final picked = await ImagePicker.pickImage(source: ImageSource.gallery);
    image = new File(picked.path);
    notifyListeners();
  }
  Future<String> uploadPic(File image) async{
    StorageReference fireBaseStoredRef = FirebaseStorage.instance.ref().child("Avatar/"+Path.basename(image.path));
    StorageUploadTask uploadTask = fireBaseStoredRef.putFile(image);
    await uploadTask.onComplete;
    String url = await fireBaseStoredRef.getDownloadURL();
    print(url);
    return url;
  }

  void changeText(String type, String value) {
    switch (type) {
      case "desc":
        desc = value;
        break;
      case "name":
        name = value;
        break;
      case "phone":
        phone = value;
        break;
      case "email":
        email = value;
        break;
    }
  }

  TextEditingController nameInit = TextEditingController();
  TextEditingController phoneInit = TextEditingController();
  TextEditingController descInit = TextEditingController();
  TextEditingController emailInit = TextEditingController();

  void prepareInit() {
    if (currentActor != null) {
      nameInit..text = currentActor.name;
      descInit..text = currentActor.decs;
      phoneInit..text = currentActor.phone;
      emailInit..text = currentActor.phone;
      notifyListeners();
      statusInit = true;
    }
  }

  Future<void> create(BuildContext context, String id) async {
    ActorRepository actorRepository = new ActorRepositoryImp();
    if(name != null && desc != null && image != null && phone != null && email != null ){
      String url = await uploadPic(image);
      ActorUpdateModel model = ActorUpdateModel(name, desc, url, phone, email);
      actorRepository.create(model, id).then((value) {
        if (value) {
          Fluttertoast.showToast(
              msg: "Create Success ! Please login again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else {
          Fluttertoast.showToast(
              msg: "Create Fail",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);
        }
      });
    }

  }

  Future<void> update(BuildContext context) async {
    ActorRepository actorRepository = new ActorRepositoryImp();
    String url;
    if(image != null){
        url = await uploadPic(image);
    }
    ActorUpdateModel model = ActorUpdateModel(
      name != null ? name : currentActor.name,
      desc != null ? desc : currentActor.decs,
      image != null? url : currentActor.image,
      phone != null ? phone : currentActor.phone,
      email != null ? email : currentActor.email,
    );
    actorRepository.update(model, currentActor.id).then((value) {
      if (value != null) {
        statusInit = false;
        Fluttertoast.showToast(
            msg: "Update Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        Navigator.of(context).pop();
        notifyListeners();
      }else{
        Fluttertoast.showToast(
            msg: "Update Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
    });
  }

  void addRoleUser(String id) async {
    UserRepository userRepository = new UserRepositoryImp();
    userRepository.addRoleUser(id).then((value) {
      if (value) {
        Fluttertoast.showToast(
            msg: "Change Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        statusInit = false;
        notifyListeners();
      }
    });
  }

  void addRoleAdmin(String id) async {
    UserRepository userRepository = new UserRepositoryImp();
    userRepository.addRoleAdmin(id).then((value) {
      if (value) {
        Fluttertoast.showToast(
            msg: "Change Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        statusInit = false;
        notifyListeners();
      }
    });
  }

  void deleteRoleAdmin(String id) async {
    UserRepository userRepository = new UserRepositoryImp();
    userRepository.removeRoleAdmin(id).then((value) {
      if (value) {
        Fluttertoast.showToast(
            msg: "Change Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        statusInit = false;
        notifyListeners();
      }
    });
  }

  void deleteRoleUser(String id) async {
    UserRepository userRepository = new UserRepositoryImp();
    userRepository.removeRoleUser(id).then((value) {
      if (value) {
        Fluttertoast.showToast(
            msg: "Change Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        statusInit = false;
        notifyListeners();
      }
    });
  }

}
