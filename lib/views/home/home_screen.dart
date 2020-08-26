import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:journey_to_west/view_models/HomeViewModel.dart';
import 'package:journey_to_west/views/home/home_body.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatelessWidget {
  HomeViewModel model;

  HomeScreen({this.model});

  @override
  Widget build(BuildContext context) {
      model.fetchCurrentUser(context);
      var size = MediaQuery.of(context).size;
    return ScopedModel<HomeViewModel>(
      model: model,
      child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                height: size.height * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      alignment: Alignment.centerLeft,
                      image: AssetImage("assets/images/undraw_pilates_gpdb.png")),
                ),
              ),
              HomeBody(),
            ],
          )

      )
    );
  }
}
