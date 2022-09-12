import 'package:flutter/material.dart';
class AppCodeTextField extends StatelessWidget {
  const AppCodeTextField({
    Key? key,
    required this.focusNode,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      maxLength: 1,
      onChanged: onChanged,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        counterText: '',
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(borderColor: Colors.blue),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(
      {Color borderColor = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 1,
        color: borderColor,
      ),
    );
  }
}
