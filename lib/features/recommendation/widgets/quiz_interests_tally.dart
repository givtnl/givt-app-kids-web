import 'package:flutter/material.dart';

class Tally extends StatelessWidget {
  Tally({required this.size, required this.tally, super.key});
  Size size;
  int tally;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(size.height * 0.015),
      padding: EdgeInsets.all(size.height * 0.015),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.height * 0.1),
        color: Color(0xFF54A1EE),
      ),
      child: Text('$tally/3',
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.025,
            fontWeight: FontWeight.w700,
          )),
    );
  }
}
