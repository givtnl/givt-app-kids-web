import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';

class RecommendationGivyBubble extends StatelessWidget {
  const RecommendationGivyBubble({
    required this.text,
    this.extraChild,
    super.key,
    this.small = false,
  });
  final String text;
  final Widget? extraChild;
  final bool small;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = small ? size.height * 0.6 : size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(height * 0.4),
      child: Container(
        width: size.width * 0.55,
        decoration: const BoxDecoration(
          color: Color.fromARGB(200, 226, 241, 246),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(height * 0.015),
              child: SvgPicture.asset(
                "images/givy_pink_bubble.svg",
                alignment: Alignment.centerLeft,
                height: height * 0.12,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: height * 0.01, vertical: 0),
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: const Color(0xFF405A66),
                    fontSize: FontUtils.getScaledFontSize(
                        inputFontSize: 31, size: size),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            extraChild ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
