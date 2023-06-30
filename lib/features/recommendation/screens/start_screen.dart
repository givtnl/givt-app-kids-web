import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StartScren extends StatelessWidget {
  const StartScren({super.key});

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
            ClipRRect(
              borderRadius: BorderRadius.circular(size.height * 0.4),
              child: Container(
                width: size.width * 0.7,
                decoration: const BoxDecoration(
                  color: Color(0xFFBED7E1),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.height * 0.08, vertical: 0),
                      child: SvgPicture.asset(
                        height: size.height * 0.20,
                        "images/givy_pencil.svg",
                      ),
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Let\'s choose a charity!',
                            style: TextStyle(
                                color: Color(0xFF405A66),
                                fontSize: 42,
                                fontWeight: FontWeight.bold)),
                        Text(
                            'Grab your parent or sibling if you want some help! ',
                            style: TextStyle(
                                color: Color(0xFF405A66),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.8,
                                height: 1.2)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: size.height * 0.05),
        child: ElevatedButton(
            onPressed: () {},
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
              child: Text('I\'m ready!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      height: 1.2)),
            )),
      ),
    );
  }
}
