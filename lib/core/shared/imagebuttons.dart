import 'package:flutter/material.dart';

Widget imageButton(String image, Function onTap) {
  return GestureDetector(
      child: Container(
        height: 45.0,
        child: Image(
          image: AssetImage('assets/images/$image'),
        ),
      ),
      onTap: onTap);
}
