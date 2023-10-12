import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_app_kids_web/features/recommendation/tags/models/tag.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';

class InterestCard extends StatelessWidget {
  const InterestCard({
    required this.interest,
    required this.width,
    required this.onPressed,
    this.isSelected = false,
    super.key,
  });

  final Tag interest;
  final void Function() onPressed;
  final double width;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: EdgeInsets.all(width * 0.02),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 25,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.width * 0.020),
            side: isSelected
                ? const BorderSide(
                    color: Color(0xFF97A486),
                    width: 2,
                  )
                : BorderSide.none,
          ),
          backgroundColor:
              isSelected ? const Color(0XFFDFF3C5) : const Color(0XFFFAF4D8),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      constraints: BoxConstraints(
                          maxWidth: size.width * 0.02,
                          maxHeight: size.width * 0.02),
                      margin: EdgeInsets.symmetric(
                        vertical: size.width * 0.005,
                      ),
                      child: Transform.scale(
                        scale: size.width * 0.001,
                        child: Radio(
                          activeColor: const Color(0XFF7AAA35),
                          value: isSelected ? 1 : 0,
                          groupValue: 1,
                          toggleable: true,
                          onChanged: (_) => onPressed(),
                        ),
                      )),
                  Expanded(
                    child: Text(
                      interest.displayText,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          color: const Color(0xFF405A66),
                          fontSize: FontUtils.getScaledFontSize(
                              inputFontSize: 16, size: size),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: SvgPicture.network(
                  interest.pictureUrl,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
