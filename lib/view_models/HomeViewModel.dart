import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journey_to_west/helpers/Constant.dart';
import 'package:journey_to_west/models/User.dart';
import 'package:journey_to_west/repos/UserRepository.dart';
import 'package:journey_to_west/views/actor/ban_and_unban/enable_actor_screen.dart';
import 'package:journey_to_west/views/actor/character_list/list_character_of_user_screen.dart';
import 'package:journey_to_west/views/actor/history/history_actor_screen.dart';
import 'package:journey_to_west/views/actor/schedule/schedule_actor_screen.dart';
import 'package:journey_to_west/views/manage_character/home/manage_character_home_screen.dart';
import 'package:journey_to_west/views/manage_tool/home/manage_tool_home_screen.dart';
import 'package:journey_to_west/views/scene/home/scene_home_screen.dart';
import 'package:journey_to_west/views/statictis_tool/statictis_tool_screen.dart';
import 'package:journey_to_west/views/tool/home/tool_home_screen.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ActorViewModel.dart';
import 'SceneViewModel.dart';
import 'ToolViewModel.dart';

class HomeViewModel extends Model {
  User currentUser;
  List<Items> myList;
  List<Items> showList;
  bool isCheck = false;
  bool isFilter = false;

  HomeViewModel() {
    myList = [item1, item2, item3, item4, item5, item6, item7, item8, item9];
  }

  Items item1 = new Items(
      title: "Enable User",
      img: "assets/icons/001-boolean.svg",
      role: "Admin",
      screen: "EnableScreen");
  Items item2 = new Items(
      title: "Shooting Schedule",
      img: "assets/icons/003-to-do-list.svg",
      role: "User",
      screen: "ScheduleScreen");
  Items item3 = new Items(
      title: "Stars", img: "assets/icons/005-star.svg", role: "Admin", screen: "ManageCharacterScreen");
  Items item4 = new Items(
      title: "Tools",
      img: "assets/icons/003-cameraman.svg",
      role: "Admin",
      screen: "ToolScreen",
      );
  Items item6 = new Items(
      title: "Characters",
      img: "assets/icons/002-sad.svg",
      role: "User",
      screen: "ListCharacterScreen");
  Items item7 = new Items(
    title: "Scenes",
    img: "assets/icons/001-story-board.svg",
    role: "Admin",
    screen: "SceneScreen",
  );
  Items item8 = new Items(
      title: "History",
      img: "assets/icons/002-history.svg",
      role: "User",
      screen: "HistoryScreen");
  Items item5 = new Items(
    title: "Add Tool",
    img: "assets/icons/001-add-to-cart.svg",
    role: "Admin",
    screen: "AddToolScreen",
    
  );
  Items item9 = new Items(
    title: "Statictis Tool",
    img: "assets/icons/001-statistics.svg",
    role: "Admin",
    screen: "StatictisToolScreen",

  );

  void changeScreen(String screen, BuildContext context) {
    switch (screen) {
      case "SceneScreen":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SceneScreen(
                      model: SceneViewModel(),
                    )));
        break;
      case "EnableScreen":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EnableActorScreen(
                      model: ActorViewModel(),
                    )));
        break;
      case "ToolScreen":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ToolHomeScreen(model: ToolViewModel())));
        break;
      case "ListCharacterScreen":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListCharacterOfUserScreen(
                      model: ActorViewModel(),
                      id: currentUser.id,
                    )));
        break;
      case "HistoryScreen":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HistoryActorScreen(
                      model: ActorViewModel(),
                      id: currentUser.id,
                    )));
        break;
      case "ScheduleScreen":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScheduleActorScreen(
                      model: ActorViewModel(),
                      id: currentUser.id,
                    )));
        break;
      case "AddToolScreen":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ManageToolHomeScreen(
                  model: SceneViewModel(),
                )));
        break;
      case "ManageCharacterScreen":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ManageCharacterHomeScreen(
                  model: SceneViewModel(),
                )));
        break;
      case "StatictisToolScreen":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StatictisToolScreen(
                  model: SceneViewModel(),
                )));
        break;
    }
  }

  void fetchCurrentUser(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get("token");
    UserRepository userRepository = UserRepositoryImp();
    if (token != null) {
      userRepository.fetchUser(token).then((value) {
        currentUser = value;
        print(currentUser.role);
        if (currentUser.status != StatusUser.DISABLE) {
          myList = myList
              .where((element) => currentUser.role.contains(element.role))
              .toList();
          isCheck = true;
          notifyListeners();
        }
      });
    } else {
      throw Exception("Fetch User Fail");
    }
  }
  Future<void> signOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("token");
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Fluttertoast.showToast(
        msg: "Please wait Admin permision",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0);
  }
// Search filter

}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  String role;
  String screen;
  Color color1;
  Color color2;

  Items(
      {this.title,
      this.subtitle,
      this.event,
      this.img,
      this.role,
      this.screen,
      this.color1 = Colors.white,
      this.color2 = Colors.black});
}
