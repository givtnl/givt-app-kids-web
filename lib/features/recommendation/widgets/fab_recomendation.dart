import 'package:flutter/material.dart';

class RecommendationFAB extends StatelessWidget {
  const RecommendationFAB({required this.text, required this.route, super.key});
  final String text;
  final String route;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.05),
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF54A1EE),
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.height * 0.02),
            ),
            minimumSize: Size(size.width * 0.2, size.height * 0.1),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.height * 0.02, vertical: size.height * 0.01),
            child: Text(text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    height: 1.2)),
          )),
    );
  }
}
