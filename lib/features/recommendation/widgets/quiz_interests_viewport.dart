import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/features/recommendation/choices/models/tag.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_interests_card.dart';

class InterestsViewPort extends StatelessWidget {
  const InterestsViewPort(
      {required this.narrow,
      required this.options,
      required this.size,
      super.key});
  final double size;
  final List<Tag> options;
  final bool narrow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size * 0.7,
      child: Center(
        child: Padding(
          padding: narrow
              ? EdgeInsets.symmetric(horizontal: size * 0.02)
              : EdgeInsets.symmetric(horizontal: size * 0.1),
          child: narrow
              ? GridView.count(
                  childAspectRatio: 2,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: options
                      .map((item) =>
                          InterestCard(narrow: narrow, item: item, size: size))
                      .toList(),
                )
              : GridView.count(
                  childAspectRatio: 2,
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  children: options
                      .map((item) =>
                          InterestCard(narrow: narrow, item: item, size: size))
                      .toList(),
                ),
        ),
      ),
    );
  }
}
