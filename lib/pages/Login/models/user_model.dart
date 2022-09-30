class UserModel {

  UserModel({
    this.id,
    this.username,
    this.password,
    this.salt
  });

  final String? id;
  final String? username;
  final String? password;
  final String? salt;

  factory UserModel.fromJson(Map<String,dynamic>json) => UserModel(
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