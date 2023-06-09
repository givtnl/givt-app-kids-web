import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WebPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEEDE4),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: size.width * 0.3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.2),
                      const Text('Welcome!',
                          style: TextStyle(
                              color: Color(0xFF54A1EE),
                              fontSize: 42,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: size.height * 0.03),
                      const Text(
                          'Hey there, future changemaker! Are you ready to make a difference in the world? With Givt4Kids, you can! \n\nHere\'s a fun and safe way to help the causes you care about. Whether it\'s a local animal shelter or a global charity, you can contribute using your \'giving allowance\' set by your parents. All you have to do is scan a QR code of the organization you want to support and decide how much you\'d like to donate from your approved funds. \n\nDon\'t worry, your parents will be with you every step of the way, keeping everything secure. So let\'s start your giving journey with Givt4Kids and see how awesome generosity can be.',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.8,
                              height: 1.2)),
                    ]),
              ),
              const Spacer(flex: 1),
              Column(
                children: [
                  SizedBox(height: size.height * 0.2),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SvgPicture.asset(
                        height: size.width * 0.25,
                        fit: BoxFit.fitHeight,
                        "images/icon-kids.svg"),
                  ),
                ],
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
