class DeliveryMan {
  late String id;
  late String firstName;
  late String identificationNumber;
  late String companyName;
  late String password;

  DeliveryMan();

  DeliveryMan.fromMap(Map<String, dynamic> map) {
    companyName = map['companyName'];
    password = map['password'];
    identificationNumber = map['identificationNumber'];
    firstName = map['firstName'];
  }

  Map<String, dynamic> toMAp() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['companyName'] = companyName;
    map['password'] = password;
    map['identificationNumber'] = identificationNumber;
    map['firstName'] = firstName;
    return map;
  }
}
