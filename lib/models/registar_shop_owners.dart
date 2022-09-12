class ShopOwners {
  late String id;
  late String gmail;
  late String firstName;
  late String lastName;
  late String storeName;
  late String mobile;
  late String city;
  late String password;
  late String confirmPassword;
  late String description;

  ShopOwners();

  ShopOwners.fromMap(Map<String, dynamic> map) {
    firstName = map['firstName'];
    lastName = map['lastName'];
    storeName = map['storeName'];
    mobile = map['mobile'];
    city = map['city'];
    password = map['password'];
    description = map['description'];
    gmail = map['gmail'];
  }

  Map<String, dynamic> toMAp() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['storeName'] = storeName;
    map['mobile'] = mobile;
    map['city'] = city;
    map['password'] = password;
    map['description'] = description;
    map['gmail'] = gmail;
    return map;
  }
}
