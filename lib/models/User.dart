class User {
  String id;
  String username;
  String name;
  String role;
  String image;
  String status;
  bool isActor;
  User({this.id, this.username,this.name, this.role, this.image, this.status, this.isActor});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        role: json["role"],
        image: json["image"],
        status: json["status"],
        isActor: json["isActor"]
    );
  }
}

class UserLoginModel {
  String username;
  String password;

  UserLoginModel(String username, String password) {
    this.username = username;
    this.password = password;
  }
}

class UserRegisterModel {
  String username;
  String password;
  String confirm;
  UserRegisterModel(this.username, this.password, this.confirm);
}
