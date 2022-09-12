class Companies {
  late String id;
  late String gmail;
  late String companyName;
  late String mobile;
  late String telephoneFix;
  late String city;
  late String password;
  late String description;

  Companies();

  Companies.fromMap(Map<String, dynamic> map) {
    companyName = map['companyName'];
    telephoneFix = map['telephoneFix'];
    mobile = map['mobile'];
    city = map['city'];
    password = map['password'];
    description = map['description'];
    gmail = map['gmail'];
  }

  Map<String, dynamic> toMAp() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['companyName'] = companyName;
    map['telephoneFix'] = telephoneFix;
    map['mobile'] = mobile;
    map['city'] = city;
    map['password'] = password;
    map['description'] = description;
    map['gmail'] = gmail;
    return map;
  }
}
