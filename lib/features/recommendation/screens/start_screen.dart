import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/recommendation/quiz/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/bubble.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givt_primary_elevated_button.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givt_secondary_elevated_button.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final anchorSize = size.aspectRatio > 1 ? size.width : size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/gradient.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 50,
            top: 50,
            child: SvgPicture.asset(
              height: anchorSize * 0.07,
              "images/transparent_logo.svg",
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  Bubble(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: FontUtils.getScaledFontSize(
                              inputFontSize: 20, size: size),
                          color: const Color(0xFF505D68),
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'Let’s choose a charity!\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Grab your parent or sibling if you want some help!',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Image.asset(
                    height: anchorSize * 0.2,
                    "images/givy_pencil_rounded_bg.png",
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GivtSecondaryElevatedButton(
                          text: 'Continue as guest',
                          onPressed: () {
                            context.read<QuizCubit>().startQuiz();
                            context.pushNamed(Pages.quizWhere.name);
                          },
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        GivtPrimaryElevatedButton(
                          text: 'Login to discover',
                          onPressed: () {
                            context.pushNamed(Pages.login.name);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
