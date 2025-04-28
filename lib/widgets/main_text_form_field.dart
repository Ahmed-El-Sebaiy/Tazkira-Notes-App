import 'package:flutter/material.dart';
Widget mainTextFormField({
  TextEditingController? controller,
  required String labelText,
  Icon? prefixIcon,
  IconButton? suffixIcon,
  bool obscureText = false,
}){
  return TextFormField(
    obscureText: obscureText,
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22,),
      ),
    ),
  );
}