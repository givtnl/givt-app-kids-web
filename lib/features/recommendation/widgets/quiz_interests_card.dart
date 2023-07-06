import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';

class InterestCard extends StatelessWidget {
  const InterestCard({required this.item, required this.size, super.key});
  final Size size;
  final Tag item;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(size.width * 0.003),
      child: Card(
        elevation: 25,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Color(0XFFFAF4D8),
        child: Stack(
          children: [
            Radio(value: 0, groupValue: 1, onChanged: (int) {}),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: size.width * 0.08,
                    child: Text(
                      item.displayText,
                      maxLines: 2,
                      style: TextStyle(
                          color: Color(0xFF405A66),
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.network(
                      item.pictureUrl,
                      width: size.width * 0.055,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
