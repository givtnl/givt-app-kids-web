import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/fab_recomendation.dart';

class WhereScreen extends StatelessWidget {
  const WhereScreen({super.key});
  static const String routeName = "/quiz-where";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        child: Column(
          children: [
            Spacer(flex: 1),
            SvgPicture.asset(
              height: size.height * 0.20,
              "images/transparent_logo.svg",
            ),
            Spacer(flex: 1),
            Text('Where would you like to help?',
                style: TextStyle(
                    color: Color(0xFF405A66),
                    fontSize: 42,
                    fontWeight: FontWeight.bold)),
            Spacer(flex: 3),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          RecommendationFAB(text: 'Next', route: '/interests'),
    );
  }
}
