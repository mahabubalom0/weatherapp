import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customebutton extends StatelessWidget {
  Color color;
  String text;
  VoidCallback onTap;
  Color? textcolor;
  Customebutton({
    super.key,
    required this.onTap,
    required this.color,
    required this.text,
    this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 53.0,
        width: MediaQuery.of(context).size.width * 0.8,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),

          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 19.0,
              color: textcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
