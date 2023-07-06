import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_interests_card.dart';

class InterestsViewPort extends StatelessWidget {
  const InterestsViewPort(
      {required this.options, required this.size, super.key});
  final double size;
  final List<Tag> options;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size * 0.7,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size * 0.1),
          child: GridView.count(
            childAspectRatio: 2,
            crossAxisCount: 4,
            shrinkWrap: true,
            children: options
                .map((item) => InterestCard(item: item, size: size))
                .toList(),
          ),
        ),
      ),
    );
  }
}
