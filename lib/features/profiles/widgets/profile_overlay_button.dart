import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_app_kids_web/features/profiles/models/profile.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';

class ProfileOverlayButton extends StatelessWidget {
  const ProfileOverlayButton({
    required this.profile,
    super.key,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final anchorSize = size.aspectRatio > 1 ? size.width : size.height;

    return Container(
      padding: const EdgeInsets.only(top: 7, bottom: 7, right: 7, left: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: profile.backgroundColorByImage,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              profile.firstName,
              style: TextStyle(
                color: Colors.white,
                fontSize: FontUtils.getScaledFontSize(
                  inputFontSize: 18,
                  size: size,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SvgPicture.network(
                profile.pictureURL,
                width: anchorSize * 0.055,
                height: anchorSize * 0.055,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
