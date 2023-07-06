import 'package:flutter/material.dart';

class Tally extends StatelessWidget {
  Tally({required this.size, required this.tally, super.key});
  double size;
  int tally;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(size * 0.01),
      padding: EdgeInsets.all(size * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.1),
        color: Color.fromARGB(222, 144, 216, 29),
      ),
      child: Text('$tally/3',
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.025,
            fontWeight: FontWeight.w700,
          )),
    );
  }
}
