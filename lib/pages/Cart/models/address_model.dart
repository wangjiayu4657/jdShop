
class AddressModel {
  AddressModel({
    this.name,
    this.tel,
    this.address,
    this.isDefault = false
  });

  String? name;
  String? tel;
  String? address;
  bool? isDefault;

  factory AddressModel.fromJson(Map<String,dynamic> json) => AddressModel(
    name: json["name"],
    tel: json["tel"],
    address: json["address"],
    isDefault: json["isDefault"]
  );

  Map<String,dynamic> toJson() => {
    "name": name,
    "tel": tel,
    "address": address,
    "isDefault": isDefault
  };
}