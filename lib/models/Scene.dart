

class Scene {
  String id, name, desc, location, status;
  String begin, end;
  int snapshot;

  Scene(
      {this.id,
      this.name,
      this.desc,
      this.location,
      this.begin,
      this.end,
      this.status,
      this.snapshot});

  factory Scene.fromJson(Map<String, dynamic> json) {
    return Scene(
        id: json["id"],
        name: json["name"],
        begin: json["time_start"].toString().split(" ")[0],
        end: json["time_end"].toString().split(" ")[0],
        desc: json["description"],
        status: json["status"],
        location: json["location"],
        snapshot: json["snapshot"]);
  }
}

class SceneCreateModel {
  String name, desc, location;
  DateTime begin, end;
  int snapshot;

  SceneCreateModel(
      this.name, this.desc, this.location, this.begin, this.end, this.snapshot);
}

class SceneUpdateModel {
  String id, name, desc, location;
  DateTime begin, end;
  int snapshot;

  SceneUpdateModel(
      {this.id,
      this.name,
      this.desc,
      this.location,
      this.begin,
      this.end,
      this.snapshot});

  factory SceneUpdateModel.fromJson(Map<String, dynamic> json) {
    return SceneUpdateModel(
        id: json["id"],
        name: json["name"],
        begin: json["time_start"],
        end: json["time_end"],
        desc: json["description"],
        location: json["location"],
        snapshot: json["snapshot"]);
  }
}

class CharacterViewModel{
  String id,sceneid, actorid, description, character, actorName, sceneName, actorImage, status, scriptLink;

  CharacterViewModel({this.id,this.sceneid, this.actorid, this.description,
      this.character, this.actorName, this.sceneName, this.actorImage, this.status, this.scriptLink});
  factory CharacterViewModel.fromJson(Map<String, dynamic> json){
    return CharacterViewModel(
      id: json["id"],
      sceneid: json["sceneid"],
      actorid: json["actorid"],
      actorName: json["actor-name"],
      actorImage: json["actor-image"],
      sceneName: json["scene-name"],
      description: json["description"],
      character: json["character"],
      status: json["status"],
      scriptLink: json["script-link"]
    );
  }


}

class CharacterCreateModel{
  String sceneId, actorId, description, character;
  String characterScript;
  CharacterCreateModel({this.characterScript, this.sceneId, this.actorId,
      this.description, this.character});
}
class CharacterUpdateModel{
  String  description, character;
  String characterScript;
  CharacterUpdateModel({this.characterScript, this.description, this.character});
}
