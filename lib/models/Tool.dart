
class Tool {
  String id, name, description, image, status;
  int amount;

  Tool(this.id,
      this.name,
      this.description,
      this.image,
      this.status,
      this.amount);

  factory Tool.fromJson(Map<String, dynamic> json) {
    return Tool(
        json["id"],
        json["name"],
        json["description"],
        json["image"],
        json["status"],
        json["amount"]);
  }
}

class ToolCreateModel {
  String name, description;
  int amount;
  String image;

  ToolCreateModel(this.name, this.description, this.image, this.amount);
}
class ToolUpdateModel {
  String name, description;
  int amount;
  String image;

  ToolUpdateModel(this.name, this.description, this.image, this.amount);
}
class ToolOrderViewModel{
  String id, toolid, name, image, sceneid, sceneName, borrowFrom, borrowTo, status;
  int amount;

  ToolOrderViewModel({this.id,this.toolid, this.name, this.image, this.sceneid,
      this.sceneName, this.borrowFrom, this.borrowTo, this.amount,this.status});
  factory ToolOrderViewModel.fromJson(Map<String, dynamic> json){
   return ToolOrderViewModel(
     id: json["id"],
     toolid: json["toolid"],
     name: json["name"],
     image: json["image"],
     sceneid: json["sceneid"],
     sceneName: json["scene_name"],
     borrowFrom: json["borrow-from"].toString().split(" ")[0],
     borrowTo: json["borrow-to"].toString().split(" ")[0],
     amount: json["amount"],
     status: json["status"]
   );
  }
}

class OrderToolCreateModel{
  String toolid;
  DateTime borrowFrom, borrowTo;
  int amount;

  OrderToolCreateModel({this.toolid, this.borrowFrom, this.borrowTo, this.amount});
}
class OrderToolUpdateModel{

}
class ToolPickdate{
  String begin,end;

  ToolPickdate({this.begin, this.end});
}
