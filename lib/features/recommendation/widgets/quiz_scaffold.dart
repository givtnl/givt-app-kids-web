import 'package:flutter/material.dart';

class QuizScaffold extends StatelessWidget {
  const QuizScaffold(
      {required this.flexChildren, required this.fab, super.key});
  final Widget fab;
  final List<Widget> flexChildren;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/gradient.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Flex(
            direction: Axis.vertical,
            children: flexChildren,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: fab);
  }
}
