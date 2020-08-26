import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:journey_to_west/views/component/round_btn.dart';

import 'package:scoped_model/scoped_model.dart';

class ActorEditBody extends StatelessWidget {
  String id;
  ActorEditBody({this.id});
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ActorViewModel>(builder: (context, child, model) {
      if(!model.statusInit){
        model.getActorById(id);
      }
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text("EDIT PROFILE",
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: .6,
                      fontFamily: "Poppins-Medium",
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(Icons.title, color: Color(0xFFee9ca7)),
                title: TextField(
                  controller: model.nameInit,
                  decoration: InputDecoration(
                    hintText: "Your name",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFee9ca7)),
                    ),
                  ),
                  onChanged: (value) {
                    model.changeText("name", value);
                  },
                ),
              ),
              ListTile(
                leading:
                Icon(Icons.description, color: Color(0xFFee9ca7)),
                title: TextField(
                  controller: model.descInit,
                  decoration: InputDecoration(
                    hintText: "Your desciption",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFee9ca7)),
                    ),
                  ),
                  onChanged: (value) {
                    model.changeText("desc", value);
                  },
                ),
              ),
              ListTile(
                leading:
                Icon(Icons.rate_review, color: Color(0xFFee9ca7)),
                title: TextField(
                  controller: model.phoneInit,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {
                    model.changeText("phone", value);
                  },
                  decoration: InputDecoration(
                      hintText: "Phone",
                      hintStyle:
                      TextStyle(color: Colors.grey, fontSize: 12.0),
                      border: InputBorder.none),
                ),
              ),
              ListTile(
                leading: FloatingActionButton(
                  onPressed: () {
                    model.pickImage();
                  },
                  backgroundColor: Color(0xFFee9ca7),
                  tooltip: 'Pick Image',
                  child: Icon(Icons.add_a_photo),
                ),
                title: Center(
                    child: model.image == null
                        ? model.currentActor.image != null ? Image.network(model.currentActor.image) :
                    Text('No image selected.')
                        : Image.file(model.image)

                ),
              ),
              RoundBtn(
                title: "EDIT PROFILE",
                press: () {
                  model.update(context);
                },
                color: Color(0xFFee9ca7),
                textColor: kTextColor,
              ),
              RoundBtn(
                title: "CANCEL",
                press: () {
                  Navigator.of(context).pop();
                },
                color: Color(0xFFFFAFBD).withOpacity(0.5),
                textColor: kTextColor,
              ),
            ],
          ),
        ),
      );
    },);
  }
}
