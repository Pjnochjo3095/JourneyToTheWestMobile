import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_to_west/models/Tool.dart';
import 'package:journey_to_west/repos/ToolRepository.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart' as Path;

class ToolViewModel extends Model {
  List<Tool> listTool = new List();
  bool isFetch = false;
  bool isDone = false;
  String name, desc, status;
  File image;
  int amount;
  Tool currentTool;
  File currentImage;
  String currentId;

  void pickImage() async {
    final picked = await ImagePicker.pickImage(source: ImageSource.gallery);
    image = new File(picked.path);
    notifyListeners();
  }
  Future<String> uploadPic(File image) async{
    StorageReference fireBaseStoredRef = FirebaseStorage.instance.ref().child("tools/"+Path.basename(image.path));
    StorageUploadTask uploadTask = fireBaseStoredRef.putFile(image);
    await uploadTask.onComplete;
    String url = await fireBaseStoredRef.getDownloadURL();
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
      case "amount":
        amount = int.parse(value);
        break;
    }
  }

  void fetchTool() {
    ToolRepository toolRepository = ToolRepositoryImp();
    toolRepository.fetchTool().then((value) {
      if (value.length >= 0) {
        listTool.clear();
        value.forEach((element) {
          listTool.add(element);
          notifyListeners();
        });
        isFetch = true;
      }
    });
  }

  Future<void> create(BuildContext context) async {
    if (name != null && desc != null && image != null && amount != null) {
      ToolRepository toolRepository = ToolRepositoryImp();
      String url = await uploadPic(image);
      ToolCreateModel model = ToolCreateModel(name, desc, url, amount);
      toolRepository.create(model).then((value) {
        if (value) {
          Fluttertoast.showToast(
              msg: "Add Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);
          listTool.clear();
          isFetch = false;
          Navigator.of(context).pop();
          notifyListeners();
        } else {
          Fluttertoast.showToast(
              msg: "Add Fail",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);
        }
      });
    }
    Fluttertoast.showToast(
        msg: "Please input all",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0);
  }

  void fetchById(String id) {
    ToolRepository toolRepository = ToolRepositoryImp();
    toolRepository.getById(id).then((value) {
      if (value != null) {
        currentTool = value;
        isDone = true;
        prepareInit();
      }
      notifyListeners();
    });
  }
  TextEditingController nameInit = TextEditingController();
  TextEditingController amountInit = TextEditingController();
  TextEditingController descInit = TextEditingController();
  void prepareInit() {
    if (currentTool != null) {
      nameInit..text = currentTool.name;
      amountInit..text = currentTool.amount.toString();
      descInit..text = currentTool.description;
      notifyListeners();
      isFetch = false;
    }
  }

  Future<void> update(BuildContext context) async {
    ToolRepository toolRepository = ToolRepositoryImp();
    String url;
    if(image != null){
      url = await uploadPic(image);
    }
    ToolUpdateModel model = ToolUpdateModel(
     name != null? name : currentTool.name,
      desc != null? desc : currentTool.description,
      image != null? url : currentTool.image,
      amount != null? amount : currentTool.amount,
    );
    toolRepository.update(model, currentTool.id).then((value) {
      if (value) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "Update Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        isFetch = false;
        listTool.clear();
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

}