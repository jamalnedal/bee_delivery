import 'package:flutter/material.dart';
import '../../controllers/fb_auth_controllers.dart';
import '../basic/helper.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with Helper {
  late TextEditingController _emailController;
  String? _emailError;
  bool f = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double landscape = MediaQuery.of(context).size.height;
    double portrait = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          //TODO: go to previous page in a correct way
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),

        //الليدينج فيه كبسة السهم ليرجعني للصفحة السابقة
        title: const Text(
          'ارسال البريد',
          style: TextStyle(
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        //عنوان الاب بار
        centerTitle: true,
        // سنترنا العنوان
        backgroundColor: const Color(0xffffcc33),

        // لون خلفيه الاب بار
        //shadowColor: Colors.black,
        // لحتى يتواجد ظل اسود تحت الاب بار
        elevation: 0, // درجة الظل
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: 20, vertical: landscape * 0.036),
          children: [
            Padding(
              padding: EdgeInsets.only(top: landscape * 0.017),
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(top: landscape * 0.005, left: 10),
                  child: const Text(
                    'أدخل البريد الالكتروني لتلقي رمز إعادة التعيين...',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscape * 0.118, left: 10, right: 10),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration:  InputDecoration(
                      errorText: _emailError,
                      label: const Text(
                        'البريد الإلكتروني ',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Tajawal'),
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 230),
                  child: Container(
                    height: 60.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffffcc33), width: 1),
                      color: const Color(0xffffcc33),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                    ),

                    //margin : const EdgeInsets.only(left: 50),
                    child: MaterialButton(
                      //زر لتاكيد تسجيل الدخول

                      onPressed: () async{
                        performForgetPassword();
                      },

                      child: const Text(
                        'ارسال',
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ]),
    );
  }

  Future<bool> performForgetPassword() async {
    if (checkData()) {
      return true;
    } else {
      return false;
    }
  }
  void controlError() {
    setState(() {
      _emailError =
      _emailController.text.isEmpty ? 'ادخل الايميل' : null;

    });
  }

  void showSnackBarMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('خطأ في المعلومات المُدخلة'),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        onVisible: () => print('Visible'),
        //to know that the error showed
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
            label: 'تخطي', textColor: Colors.white, onPressed: () {})));
  }

  bool checkData() {
    if (_emailController.text.isNotEmpty) {
      forgetPassword();
      controlError();
      return true;
    }else {
      controlError();
      showSnackBarMessage();
      return false;
    }

    //TODO: SHOW SNACK BAR
    showsnakbar(Context: context, massage: 'ادخل الحقل المطلوب',error: true);
    return false;
  }

  Future<void> forgetPassword() async {
    bool status = await FbAuthControllers()
        .forgetPassword(context, email: _emailController.text);
    if (status) {
      showsnakbar(Context: context, massage: 'لقد تلقيت رسالة على ايميلك قم بمراجعتها');
      Navigator.pushReplacementNamed(context, '/online_login_screen');
    }
  }
}
