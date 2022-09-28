class LoginModel {

  LoginModel({
    this.id,
    this.username,
    this.password,
    this.salt
  });

  final String? id;
  final String? username;
  final String? password;
  final String? salt;

  factory LoginModel.fromJson(Map<String,dynamic>json) => LoginModel(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    salt: json["salt"]
  );

  Map<String,dynamic> toJson() => {
    "id": id,
    "username": username,
    "password": password,
    "salt": salt
  };
}