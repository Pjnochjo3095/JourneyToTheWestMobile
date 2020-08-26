import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:journey_to_west/views/component/round_btn.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateProfileBody extends StatelessWidget {
  String id;

  CreateProfileBody({this.id});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ActorViewModel>(builder: (context, child, model) {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text("CREATE PROFILE",
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
                leading:
                Icon(Icons.email, color: Color(0xFFee9ca7)),
                title: TextField(
                  decoration: InputDecoration(
                    hintText: "Your email",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFee9ca7)),
                    ),
                  ),
                  onChanged: (value) {
                    model.changeText("email", value);
                  },
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
                    child: model.image == null? Text('No image selected.') : Image.file(model.image)
                ),
              ),

              RoundBtn(
                title: "CREATE PROFILE",
                press: () {
                  model.create(context, id);
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
