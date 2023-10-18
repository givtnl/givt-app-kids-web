import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.width,
    required this.onPressed,
    this.margin = const EdgeInsets.symmetric(horizontal: 15),
  }) : super(key: key);

  final double width;
  final String name;
  final String imageUrl;
  final EdgeInsets margin;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            iconSize: width,
            onPressed: onPressed,
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SvgPicture.network(
                imageUrl,
                width: width,
                height: width,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: onPressed,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontUtils.getScaledFontSize(
                  inputFontSize: 17,
                  size: MediaQuery.sizeOf(context),
                ),
                color: const Color(0xFF3B3240),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
