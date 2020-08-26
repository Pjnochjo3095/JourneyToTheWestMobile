import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/view_models/ActorViewModel.dart';
import 'package:journey_to_west/view_models/HomeViewModel.dart';
import 'package:journey_to_west/views/Component/category_card.dart';
import 'package:journey_to_west/views/actor/create_profile/create_profile_actor_screen.dart';
import 'package:journey_to_west/views/actor/detail/actor_detail_screen.dart';
import 'package:journey_to_west/views/component/search_box.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HomeViewModel>(
      builder: (context, child, model) {
        if (model.isCheck) {
          return Stack(
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            alignment: Alignment.center,
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kBackgroundColor),
                            child: model.currentUser.role.contains("User") || model.currentUser.role.contains("")
                                ? FlatButton(
                                    child: SvgPicture.asset(
                                      "assets/icons/user-icon.svg",
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => model.currentUser.isActor ? model.currentUser.role != null ?ActorDetailScreen(
                                                      model: ActorViewModel(),
                                                      id: model.currentUser.id,
                                                    ): model.signOut(context)
                                                  : CreateProfileScreen(
                                                      model: ActorViewModel(),
                                                id: model.currentUser.id,
                                                    )));
                                    },
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1, style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  )
                                : Container(),
                          ),
                        ),
                      ),
                      Text(
                        model.currentUser.isActor
                            ? "Hi " + model.currentUser.name
                            : "Hi " + model.currentUser.username,
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 40,),
                      Flexible(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 0.95,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          children: model.myList.map((data) {
                            return CategoryCard(
                              title: data.title,
                              svgSrc: data.img,
                              press: () {
                                model.changeScreen(data.screen, context);
                              },
                              color1: data.color1,
                              color2: data.color2,
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
