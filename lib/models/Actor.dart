

class Actor{
  String id,name,decs,image,phone,email;
  bool status;
  Actor({
    this.id,
    this.name,
    this.decs,
    this.image,
    this.phone,
    this.email,
    this.status,
  });

  factory Actor.fromJson(Map<String, dynamic> json){
    return Actor(
        id: json["id"],
        name: json["name"],
        decs: json["description"],
        image: json["image"],
        phone: json["phone"],
        email: json["email"],
        status: json["status"],
    );
  }
}
class ActorUpdateModel{
  String desc,phone,email,name;
  String avatar;

  ActorUpdateModel( this.name,this.desc, this.avatar, this.phone, this.email);
}
class CharacterModel{
  String sceneId, sceneName, character, script;
  CharacterModel({this.sceneId, this.sceneName, this.character, this.script});
  factory CharacterModel.fromJson(Map<String, dynamic> json){
    return CharacterModel(
      sceneId: json["sceneid"],
      sceneName: json["scene_name"],
      character: json["character"],
      script : json["script_link"],
    );
  }
}

class SceneView {
  String id, name, desc, location, status, character;
  String begin, end;
  int snapshot;

  SceneView(
      {this.id,
        this.name,
        this.desc,
        this.location,
        this.begin,
        this.end,
        this.status,
        this.snapshot,
        this.character
      });

  factory SceneView.fromJson(Map<String, dynamic> json) {
    return SceneView(
        id: json["id"],
        name: json["name"],
        begin: json["time_start"].toString().split(" ")[0],
        end: json["time_end"].toString().split(" ")[0],
        desc: json["description"],
        status: json["status"],
        location: json["location"],
        snapshot: json["snapshot"],
        character: json["character"]
    );
  }
}