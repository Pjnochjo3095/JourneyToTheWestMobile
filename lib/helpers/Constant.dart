import 'package:flutter/material.dart';

//const kPrimaryColor = Color(0xFF0C9889);
const kPrimaryColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBackgroundColor = Color(0xFFFAF6F3);
const kActiveIconColor = Color(0xFFE68342);
const kShadowColor = Color(0xFFE6E6E6);
const kBackgroundBehindColor= Color(0xFFE6AC8A);
const kCardSceneColor= Color(0xFFF0DBCF);
const kCardSceneColor2= Color(0xFFE6AE8E);
const double kDefaultPadding = 20.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(0,10),
  blurRadius: 20,
  color: Colors.black12
);
class SceneColor{
  static const Color primaryColor = Color(0xFFF19845);
  static const Color secondaryColor = Color(0xFFF0DBCF);
  static const Color layoutColor= Color(0xFFE6AC8A);
  static const Color backgroundColor= Color(0xFFFAF6F3);
  static const Color secondaryBackgroundColor= Color(0xFFF0DACD);
  static const Color activeColor= Color(0xFFE68342);
}
class ToolColor{
  static const Color primaryColor = Color(0xFF06f245);
  static const Color secondaryColor = Color(0xFF8DD069);
  static const Color layoutColor= Color(0xFF8BEB90);
  static const Color backgroundColor= Color(0xFFFAF6F3);
  static const Color secondaryBackgroundColor= Color(0xFFDBF9DC);
  static const Color activeColor= Color(0xFF06f245);
}
class StatusCreate{
  static const String DONE ="Done";
  static const String FAIL ="Fail";
  static const String ERROR ="Error";
}
class StatusUser{
  static const String ENABLE = "Enable";
  static const String DISABLE = "Disable";
}
class StatusScene{
  static const String NEW = "New";
  static const String PROCESSING = "Processing";
  static const String DONE = "Done";
  static const String DELETE = "Delete";
}
class StatusTool{
  static const String OUTOFSTOCK = "OutOfStock";
  static const String AVAILABLE = "Available";
  static const String DELETED = "Deleted";
}
class StatusOrder{
  static const String NEW = "New";
  static const String DELETED = "Deleted";
}
class RootApi{
//  static const String API_ROOT = "http://192.168.1.71:52833/";
  static const String API_ROOT = "https://taydukicuanhut.azurewebsites.net/";

}
class UserAPI{
  static const String LOGIN = RootApi.API_ROOT+"api/user/login";
  static const String FETCH_USER = RootApi.API_ROOT+"api/user";
  static const String REGISTER_ACCOUNT = RootApi.API_ROOT+"api/user";
  static const String ADD_ROLE_ADMIN = RootApi.API_ROOT + "api/user/add-role-admin?userId=";
  static const String ADD_ROLE_USER = RootApi.API_ROOT + "api/user/add-role-user?userId=";
  static const String DELETE_ROLE_ADMIN = RootApi.API_ROOT + "api/user/delete-role-admin?userId=";
  static const String DELETE_ROLE_USER = RootApi.API_ROOT + "api/user/delete-role-user?userId=";
}
class SceneAPI{
  static const String FETCH_LIST_SCENE = RootApi.API_ROOT + "api/scene?sort=asc%20name";
  static const String CREATE_SCENE = RootApi.API_ROOT + "api/scene";
  static const String UPDATE_SCENE = RootApi.API_ROOT + "api/scene?sceneId=";
  static const String DELETE_SCENE = RootApi.API_ROOT + "api/scene?sceneId=";
  static const String GET_BY_ID = RootApi.API_ROOT + "api/scene/get-scene-by-id?sceneId=";
  static const String FETCH_TOOLS = RootApi.API_ROOT + "api/scene/get-tools-of-scene?sceneId=";
  static const String FETCH_CHARACTERS = RootApi.API_ROOT + "api/scene/get-characters?sceneId=";
  static const String FINISH_SCENE = RootApi.API_ROOT + "api/scene/finish?sceneId=";
  static const String DELETE_TOOL_OF_SCENE = RootApi.API_ROOT + "api/scene/delete-order?orderId=";
  static const String ADD_TOOL_OF_SCENE = RootApi.API_ROOT + "api/scene/add-tool";
  static const String ADD_CHARACTER_OF_SCENE = RootApi.API_ROOT + "api/scene/add-character";
  static const String DELETE_CHARACTER_OF_SCENE = RootApi.API_ROOT + "api/scene/delete-character?characterId=";
  static const String GET_ALL_ORDER = RootApi.API_ROOT + "api/scene/all-tool?";
}
class ActorAPI{
static const String FETCH_LIST_ACTOR = RootApi.API_ROOT + "api/actor?limit=-1";
static const String GET_ACTOR_BY_ID = RootApi.API_ROOT + "api/actor/get-by-id?id=";
static const String ENABlE_ACTOR_BY_ID = RootApi.API_ROOT + "api/actor/enable-actor?id=";
static const String UPDATE_ACTOR = RootApi.API_ROOT + "api/actor?id=";
static const String GET_ROLES = RootApi.API_ROOT + "api/actor/get-roles";
static const String CREATE_ACTOR = RootApi.API_ROOT + "api/actor";
static const String FETCH_CHARACTERS = RootApi.API_ROOT + "api/actor/get-character-by-id?actorId=";
static const String FETCH_SCENES = RootApi.API_ROOT + "api/actor/get-scenes?actorId=";
static const String FETCH_SCENES_DONE = RootApi.API_ROOT + "api/actor/get-scenes-is-finished?actorId=";
}
class ToolAPI{
  static const String FETCH_LIST_TOOL = RootApi.API_ROOT + "api/tool";
  static const String CREATE_TOOL = RootApi.API_ROOT + "api/tool";
  static const String UPDATE_TOOL = RootApi.API_ROOT + "api/tool?toolId=";
  static const String DELETE_TOOL = RootApi.API_ROOT + "api/tool";
  static const String GET_BY_ID = RootApi.API_ROOT + "api/tool/get-tool-by-id?toolId=";
}

