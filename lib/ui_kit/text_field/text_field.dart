import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final double width;
  final double? height;
  final TextEditingController controller;
  const AppTextField(
      {super.key,
      this.width = double.infinity,
      this.height,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: Color(0xFFD8F0FD),
        ),
        borderRadius: BorderRadius.circular(39),
        boxShadow: [
          const BoxShadow(
            color: Color(0x72000000),
            blurRadius: 4,
            offset: Offset(0, 5),
            spreadRadius: 0,
          )
        ],
      ),
      child: CupertinoTextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: 'Araside',
            fontWeight: FontWeight.w400,
            height: 0,
            shadows: [
              Shadow(
                  // bottomLeft
                  offset: Offset(-1.5, -1.5),
                  color: Color(0xFF3256A2)),
              Shadow(
                  // bottomRight
                  offset: Offset(1.5, -1.5),
                  color: Color(0xFF3256A2)),
              Shadow(
                  // topRight
                  offset: Offset(1.5, 1.5),
                  color: Color(0xFF3256A2)),
              Shadow(
                  // topLeft
                  offset: Offset(-1.5, 1.5),
                  color: Color(0xFF3256A2)),
            ]),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFFABC7EC), Color(0xFF9DBFE6)],
          ),
          borderRadius: BorderRadius.circular(39),
        ),
      ),
    );
  }
}
