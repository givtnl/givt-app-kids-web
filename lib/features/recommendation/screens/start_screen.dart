import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/recommendation/quiz/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/fab_recomendation.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool tooNarrow =
        (MediaQuery.of(context).orientation == Orientation.portrait) &&
            (MediaQuery.of(context).size.width < 600);
    final anchorSize = MediaQuery.of(context).size.aspectRatio > 1
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/gradient.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 1),
            SvgPicture.asset(
              height: anchorSize * 0.1,
              "images/transparent_logo.svg",
            ),
            const Spacer(flex: 1),
            tooNarrow
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(anchorSize * 0.4),
                        color: const Color(0xFFBED7E1)),
                    padding: EdgeInsets.symmetric(
                        horizontal: anchorSize * 0.05, vertical: 0),
                    child: SvgPicture.asset(
                      height: anchorSize * 0.1,
                      "images/givy_pencil.svg",
                    ),
                  )
                : const SizedBox(),
            tooNarrow ? SizedBox(height: anchorSize * 0.05) : const SizedBox(),
            ClipRRect(
              borderRadius: BorderRadius.circular(anchorSize * 0.4),
              child: Container(
                width: anchorSize * 0.7,
                decoration: const BoxDecoration(
                  color: Color(0xFFBED7E1),
                ),
                child: Row(
                  mainAxisAlignment: tooNarrow
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    tooNarrow
                        ? SizedBox(width: anchorSize * 0.05)
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: anchorSize * 0.05, vertical: 0),
                            child: SvgPicture.asset(
                              height: anchorSize * 0.1,
                              "images/givy_pencil.svg",
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.all(anchorSize * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Let\'s choose a charity!',
                              style: TextStyle(
                                  color: const Color(0xFF405A66),
                                  fontSize: anchorSize * 0.03,
                                  fontWeight: FontWeight.bold)),
                          Text(
                              'Grab your parent or sibling if you want some help! ',
                              style: TextStyle(
                                  color: Color(0xFF405A66),
                                  fontSize: anchorSize * 0.015,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.8,
                                  height: 1.2)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onLongPress: () {
          context.goNamed(Pages.login.name);
        },
        child: RecommendationFAB(
          active: true,
          text: 'I\'m ready!',
          onClicked: () {
            context.read<QuizCubit>().startQuiz();
            context.goNamed(Pages.quizWhere.name);
          },
        ),
      ),
    );
  }
}
