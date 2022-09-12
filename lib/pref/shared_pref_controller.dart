import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys {
  gmailShop,
  passwordShop,
  loginStatue,
  gmailCompanies,
  passwordCompanies,
  companyName,
  identificationNumberMan,
  passwordMan,
  name,
  loginStatusMan,
  deliveryEmployeeName,
  loginStatueCompany
}

class SharedPrefController {
  static final SharedPrefController _instance = SharedPrefController._();
  late SharedPreferences _sharedPreferences;

  factory SharedPrefController() {
    return _instance;
  }

  SharedPrefController._();

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveLoginShopOwners(
      {required String gmail, required String password}) async {
    await _sharedPreferences.setString(
        PrefKeys.passwordShop.toString(), password);
    await _sharedPreferences.setString(PrefKeys.gmailShop.toString(), gmail);
  }

  Future<void> saveLoginCompaniese(
      {required String gmail,
      required String password,
      required String companyName,
      bool? loginStatueCompany}) async {
    await _sharedPreferences.setString(
        PrefKeys.passwordCompanies.toString(), password);
    await _sharedPreferences.setString(
        PrefKeys.gmailCompanies.toString(), gmail);
    await _sharedPreferences.setString(
        PrefKeys.companyName.toString(), companyName);
    await _sharedPreferences.setBool(
        PrefKeys.loginStatueCompany.toString(), true);
  }

  Future<void> saveLoginMan(
      {required String identificationNumberMan,
      required String password,
      required String name,
      required String companyName}) async {
    await _sharedPreferences.setString(
        PrefKeys.passwordMan.toString(), password);
    await _sharedPreferences.setString(
        PrefKeys.identificationNumberMan.toString(), identificationNumberMan);
    await _sharedPreferences.setString(PrefKeys.name.toString(), name);
    await _sharedPreferences.setString(
        PrefKeys.companyName.toString(), companyName);
    await _sharedPreferences.setBool(PrefKeys.loginStatusMan.toString(), true);
  }

  Future<void> deliveryEmployeeName(
      {required String deliveryEmployeeName}) async {
    await _sharedPreferences.setString(
        PrefKeys.deliveryEmployeeName.toString(), deliveryEmployeeName);
  }

  String get gmailShop =>
      _sharedPreferences.getString(PrefKeys.gmailShop.toString()) ?? '';

  String get passwordShop =>
      _sharedPreferences.getString(PrefKeys.passwordShop.toString()) ?? '';

  String get identificationNumberMan =>
      _sharedPreferences
          .getString(PrefKeys.identificationNumberMan.toString()) ??
      '';

  String get passwordMan =>
      _sharedPreferences.getString(PrefKeys.passwordMan.toString()) ?? '';

  String get name =>
      _sharedPreferences.getString(PrefKeys.name.toString()) ?? '';

  String get gmailCom =>
      _sharedPreferences.getString(PrefKeys.gmailCompanies.toString()) ?? '';

  String get passwordCom =>
      _sharedPreferences.getString(PrefKeys.passwordCompanies.toString()) ?? '';

  bool get loginStatue =>
      _sharedPreferences.getBool(PrefKeys.loginStatue.toString()) ?? false;

  bool get loginStatueCompany =>
      _sharedPreferences.getBool(PrefKeys.loginStatueCompany.toString()) ??
      false;

  bool get loginStatusMan =>
      _sharedPreferences.getBool(PrefKeys.loginStatusMan.toString()) ?? false;

  String get companyName =>
      _sharedPreferences.getString(PrefKeys.companyName.toString()) ?? '';

  String get deliveryEmployeeNames =>
      _sharedPreferences.getString(PrefKeys.deliveryEmployeeName.toString()) ?? '';

  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }
}
