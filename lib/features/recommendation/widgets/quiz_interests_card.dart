import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';

import '../cubit/choices-cubit/choices_cubit.dart';

class InterestCard extends StatelessWidget {
  const InterestCard({required this.item, required this.size, super.key});
  final double size;
  final Tag item;
  @override
  Widget build(BuildContext context) {
    final userChoices = context.watch<ChoicesCubit>();

    return Container(
      margin: EdgeInsets.all(size * 0.003),
      child: ElevatedButton(
        onPressed: () => userChoices.chooseInterest(item),
        style: ElevatedButton.styleFrom(
          elevation: 25,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: userChoices.state.interests.contains(item)
                ? const BorderSide(
                    color: Color(0xFF97A486),
                    width: 2,
                  )
                : BorderSide.none,
          ),
          backgroundColor: userChoices.state.interests.contains(item)
              ? Color(0XFFDFF3C5)
              : Color(0XFFFAF4D8),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size * 0.01),
              child: Radio(
                  activeColor: Color(0XFF7AAA35),
                  value: userChoices.state.interests.contains(item) ? 1 : 0,
                  groupValue: 1,
                  toggleable: true,
                  onChanged: (int) => userChoices.chooseInterest(item)),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: size * 0.08,
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
                      width: size * 0.055,
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
