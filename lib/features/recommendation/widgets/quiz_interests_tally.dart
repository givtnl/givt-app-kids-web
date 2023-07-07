import 'package:flutter/material.dart';

class Tally extends StatelessWidget {
  Tally({required this.size, required this.tally, super.key});
  double size;
  int tally;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(size * 0.01),
      padding: EdgeInsets.fromLTRB(
          size * 0.01, size * 0.003, size * 0.01, size * 0.004),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.1),
        color: Color(0xFF54A1EE),
      ),
      child: Text('$tally/3',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: size * 0.025,
            fontWeight: FontWeight.w700,
          )),
    );
  }
}
