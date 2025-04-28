import 'package:flutter/material.dart';

Widget mainElevatedButton({
  required String text,
  required Function() onPressed,
  IconData? icon,
}){
  return ElevatedButton(
    style: ButtonStyle(
      minimumSize: WidgetStatePropertyAll<Size>(
        Size(200 , 50),
      ),
      backgroundColor: WidgetStatePropertyAll<Color>(
        Color(0xff001523),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(width: 20,),
          Icon(
            icon,
            color: Color(0xff6E4230),
            size: 28,
          ),
        ],
      ),
  );
}