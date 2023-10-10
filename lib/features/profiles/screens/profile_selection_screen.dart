import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/profiles/cubit/profiles_cubit.dart';
import 'package:givt_app_kids_web/features/profiles/models/profile.dart';
import 'package:givt_app_kids_web/features/profiles/widgets/profile_item.dart';
import 'package:givt_app_kids_web/features/recommendation/quiz/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/shared/widgets/givt_continue_button.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';
import 'package:go_router/go_router.dart';

import 'package:givt_app_kids_web/shared/widgets/back_button.dart'
    as givt_widgets;

class ProfileSelectionScreen extends StatelessWidget {
  const ProfileSelectionScreen({Key? key}) : super(key: key);

  static const int maxProfilesToShow = 4;

  Future<void> _selectProfile(BuildContext context, Profile profile) async {
    context.read<ProfilesCubit>().setActiveProfile(profile);
    await AnalyticsHelper.logEvent(
      eventName: AmplitudeEvent.profilePressed,
      eventProperties: {
        "profile_name": profile.firstName,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final anchorSize = size.aspectRatio > 1 ? size.width : size.height;
    return BlocConsumer<ProfilesCubit, ProfilesState>(
        listener: (context, state) {
      log('profiles state changed on $state');
      if (state is ProfilesExternalErrorState) {
        log(state.errorMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Cannot download profiles. Please try again later.",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: const Color(0xFFEEEDE4),
        body: Stack(
          children: [
            Positioned.fill(
              child: state is ProfilesLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF0E90CC),
                      ),
                    )
                  : state.profiles.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "There are no profiles attached to the current user.\nPlease use Givt app to create profiles.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF3B3240),
                                  fontSize: FontUtils.getScaledFontSize(
                                      inputFontSize: 25, size: size),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.height * 0.08,
                              ),
                              SvgPicture.asset(
                                height: anchorSize * 0.12,
                                "images/transparent_logo.svg",
                              ),
                              SizedBox(
                                height: size.height * 0.09,
                              ),
                              Text(
                                "Who would like to give?",
                                style: TextStyle(
                                  color: const Color(0xFF3B3240),
                                  fontSize: FontUtils.getScaledFontSize(
                                      inputFontSize: 20, size: size),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.08,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: state.profiles
                                      .map(
                                        (profile) => ProfileItem(
                                          width: anchorSize * 0.12,
                                          name: profile.firstName,
                                          imageUrl: profile.pictureURL,
                                          onPressed: () {
                                            _selectProfile(context, profile);
                                            context
                                                .read<QuizCubit>()
                                                .startQuiz();
                                            context.pushReplacementNamed(
                                                Pages.quizWhere.name);
                                          },
                                        ),
                                      )
                                      .take(maxProfilesToShow)
                                      .toList(),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.1,
                              ),
                            ],
                          ),
                        ),
            ),
            Positioned(
              top: 30,
              left: 30,
              child: givt_widgets.BackButton(
                pageName: Pages.login.name,
              ),
            ),
            Positioned(
              right: 30,
              bottom: 30,
              child: GivtContinueButton(
                pageName: Pages.profileSelection.name,
              ),
            ),
          ],
        ),
      );
    });
  }
}
