import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/choices-cubit/choices_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({required this.item, required this.size, super.key});
  final Size size;
  final Tag item;
  @override
  Widget build(BuildContext context) {
    final userChoices = context.watch<ChoicesCubit>();
    return Container(
      height: size.height * 0.3,
      width: size.width * 0.25,
      padding: EdgeInsets.all(size.width * 0.005),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 25,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: userChoices.state.location == item
                  ? const BorderSide(
                      color: Color(0xFF97A486),
                      width: 2,
                    )
                  : BorderSide.none,
            ),
            backgroundColor: userChoices.state.location == item
                ? Color(0XFFDFF3C5)
                : Color(0XFFFAF4D8),
          ),
          onPressed: () => userChoices.chooseLocation(item),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.network(item.pictureUrl),
              Text(
                item.displayText,
                style: const TextStyle(
                    color: Color(0xFF405A66),
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              )
            ],
          )),
    );
  }
}
