import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_app_kids_web/features/profiles/cubit/profiles_cubit.dart';
import 'package:givt_app_kids_web/features/profiles/models/profile.dart';
import 'package:givt_app_kids_web/features/profiles/screens/profile_selection_overlay_screen.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';

class ProfileWalletButton extends StatelessWidget {
  const ProfileWalletButton({
    required this.pageName,
    this.onPressed,
    super.key,
  });

  final String pageName;
  final void Function()? onPressed;

  void _showOverlayScreen(BuildContext context, Profile activeProfile) {
    AnalyticsHelper.logEvent(
        eventName: AmplitudeEvent.profileSwitchButtonPressed,
        eventProperties: {
          'current_profile_name': activeProfile.firstName,
          'page_name': pageName,
        });

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            const ProfileSelectionOverlayScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilesCubit, ProfilesState>(
      builder: (context, state) {
        if (state.activeProfile == const Profile.empty()) {
          return Container();
        }

        final size = MediaQuery.sizeOf(context);
        final anchorSize = size.aspectRatio > 1 ? size.width : size.height;
        return GestureDetector(
          onTap: onPressed ??
              () => _showOverlayScreen(context, state.activeProfile),
          child: Card(
            elevation: 3,
            color: const Color(0xFF54A1EE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding:
                  const EdgeInsets.only(top: 7, bottom: 7, right: 7, left: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.activeProfile.firstName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontUtils.getScaledFontSize(
                            inputFontSize: 18,
                            size: size,
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Opacity(
                            opacity: state is ProfilesLoadingState ? 0 : 1,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: FontUtils.getScaledFontSize(
                                    inputFontSize: 30,
                                    size: size,
                                  ),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: "\$ ",
                                    style: TextStyle(
                                      fontSize: FontUtils.getScaledFontSize(
                                        inputFontSize: 16,
                                        size: size,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: state.activeProfile.wallet.balance
                                        .toStringAsFixed(2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (state is ProfilesLoadingState)
                            const Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Padding(
                                padding: EdgeInsets.only(top: 3),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SvgPicture.network(
                      state.activeProfile.pictureURL,
                      width: anchorSize * 0.055,
                      height: anchorSize * 0.055,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
