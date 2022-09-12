import 'package:flutter/material.dart';

mixin Helper {
  void showsnakbar(
      {required BuildContext Context,
      required String massage,
      bool error = false}) {
    ScaffoldMessenger.of(Context).showSnackBar(
      SnackBar(
        content: Text(massage),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
