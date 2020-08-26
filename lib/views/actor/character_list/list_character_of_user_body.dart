import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ListCharacterOfUserBody extends StatelessWidget {
  String id;

  ListCharacterOfUserBody();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant<ActorViewModel>(
      builder: (context, child, model) {
        if (model.characters != null) {
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: Text(
                "List Character",
                style: TextStyle(fontSize: 20),
              ),
            ),
            body: model.characters.length == 0
                ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "You don't have character",
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      itemCount: model.characters.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: size.width,
                          height: 100,
                          margin: EdgeInsets.only(
                              bottom: 20, left: 10, right: 10),
                          decoration: BoxDecoration(
                              boxShadow: [kDefaultShadow],
                              border: Border.all(
                                  color: kTextColor,
                                  style: BorderStyle.solid,
                                  width: 0.5)),
                          child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              title: Text(
                                  "Character : " +
                                      model.characters[index].character,
                                  style: TextStyle(
                                      fontSize: 18, color: kTextColor)),
                              subtitle: Text(
                                  "Scene Name : " +
                                      model.characters[index].sceneName,
                                  style: TextStyle(
                                      fontSize: 18, color: kTextColor)),
                              trailing: RaisedButton(
                                onPressed: () async {
                                  if (await canLaunch(
                                      model.characters[index].script)) {
                                    await launch(
                                        model.characters[index].script);
                                  }
                                },
                                child: Icon(Icons.book),
                                color: Colors.blue.withOpacity(0.5),
                                colorBrightness: Brightness.light,
                              )),
                        );
                      },
                    ),
                  ),
          );
        }
        return Container();
      },
    );
  }
}
