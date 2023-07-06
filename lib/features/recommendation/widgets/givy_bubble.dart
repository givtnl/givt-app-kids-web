import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GivyBubble extends StatelessWidget {
  const GivyBubble({required this.text, this.extraChild, super.key});
  final String text;
  final Widget? extraChild;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.4),
      child: Container(
        width: size.width * 0.7,
        decoration: const BoxDecoration(
          color: Color.fromARGB(200, 226, 241, 246),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(size.height * 0.015),
              child: SvgPicture.asset(
                "images/givy_pink_bubble.svg",
                alignment: Alignment.centerLeft,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.height * 0.01, vertical: 0),
                child: Text(text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xFF405A66),
                        fontSize: 42,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            extraChild ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
