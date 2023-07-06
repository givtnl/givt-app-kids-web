import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/features/recommendation/models/quiz_question.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_location_card.dart';

class LocationViewport extends StatelessWidget {
  const LocationViewport(
      {required this.options, required this.size, super.key});
  final double size;
  final List<Tag> options;
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: options
            .map((item) => LocationCard(item: item, size: size))
            .toList());
  }
}
