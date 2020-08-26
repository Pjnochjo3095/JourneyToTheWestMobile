import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:journey_to_west/views/actor/edit/actor_edit_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class ActorDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModelDescendant<ActorViewModel>(
      builder: (context, child, model) {
        if (model.currentActor != null) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                Container(
                  width: size.width,
                  height: size.height * 0.35,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/Piggy_Pink.jpg"),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(model.currentActor.image))),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        child: Text(
                          model.currentActor.name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        child: Text(
                          model.currentActor.decs,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.3,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: kTextColor.withOpacity(0.15),
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [kDefaultShadow],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.phone_android,
                          size: 20,
                          color: Color(0xFFee9ca7),
                        ),
                        title: Text(
                          "Phone",
                          style:
                              TextStyle(fontSize: 24, color: Color(0xFFee9ca7)),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        subtitle: Text(
                          model.currentActor.phone,
                          style: TextStyle(fontSize: 20, color: kTextColor),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                          size: 20,
                          color: Color(0xFFee9ca7),
                        ),
                        title: Text(
                          "Email",
                          style:
                              TextStyle(fontSize: 24, color: Color(0xFFee9ca7)),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        subtitle: Text(
                          model.currentActor.email,
                          style: TextStyle(fontSize: 20, color: kTextColor),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.12,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: kTextColor.withOpacity(0.15),
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [kDefaultShadow],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "Status",
                            style: TextStyle(
                                fontSize: 24, color: Color(0xFFee9ca7)),
                          ),
                          subtitle: Text(
                            model.currentActor.status.toString(),
                            style: TextStyle(fontSize: 24, color: kTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.1,
                  margin: EdgeInsets.only(left: 30, right: 30,top: 10,bottom: 10),
                  decoration: BoxDecoration(color: Color(0xFFee9ca7),borderRadius: BorderRadius.circular(24)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return ActorEditScreen(model: model, id: model.currentActor.id,);
                      },));
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(color: kTextColor, fontSize: 24),
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.06,
                  margin: EdgeInsets.only(left: 100, right: 100),
                  decoration:  BoxDecoration(color: Color(0xFFFFAFBD).withOpacity(0.5),borderRadius: BorderRadius.circular(40)),
                  child: FlatButton(
                    onPressed: () {
                      model.signOut(context);
                    },
                    child: Text(
                      "Sign out",
                      style: TextStyle(color: kTextColor, fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Container(
          color: Colors.white,
        );
      },
    );
  }
}
