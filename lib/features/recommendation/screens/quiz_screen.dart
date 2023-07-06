import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/choices-cubit/choices_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/fab_recomendation.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givy_bubble.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_interests_viewport.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_location_viewport.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_scaffold.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WhereScreen extends StatelessWidget {
  WhereScreen({super.key});
  static const String routeName = "/quiz-where";

  final CarouselController _controller = CarouselController();

  // _getButtonActiveState(BuildContext context) {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    log('we are on question ${context.watch<ChoicesCubit>().state.questionIndex}');
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        return BlocBuilder<ChoicesCubit, ChoicesState>(
          builder: (context, choices) {
            return QuizScaffold(
              flexChildren: [
                Spacer(),
                Flexible(
                  flex: 3,
                  child: GivyBubble(
                    text: state is QuizLoading
                        ? 'Loading...'
                        : state.questions.isEmpty
                            ? "Sorry, something is off..."
                            : state.questions[choices.questionIndex].question,
                  ),
                ),
                CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: size.height * 0.7,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.vertical,
                      //scrollPhysics: NeverScrollableScrollPhysics(),
                    ),
                    items: state is QuizLoading
                        ? [
                            Center(
                              child: LoadingAnimationWidget.waveDots(
                                  color: Color(0xFF54A1EE),
                                  size: size.width * 0.2),
                            )
                          ]
                        : state.questions.isEmpty
                            ? [SizedBox()]
                            : [
                                LocationViewport(
                                  options: state.questions[0].options,
                                  size: size,
                                ),
                                InterestsViewPort(
                                    options: state.questions[1].options,
                                    size: size),
                                Center(
                                  child: LoadingAnimationWidget.waveDots(
                                      color: Color(0xFF54A1EE),
                                      size: size.width * 0.2),
                                ),
                              ]),
                Spacer(flex: 4),
              ],
              fab: RecommendationFAB(
                active: state is QuizStarted
                    ? choices is WhereSelected
                        ? true
                        : choices is InterestsSelected
                            ? choices.interests.length == 3
                                ? true
                                : false
                            : false
                    : true,
                text: state is QuizStarted ? 'Next' : 'Restart',
                onClicked: state is QuizStarted == false
                    ? () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    : choices is WhereSelected
                        ? () {
                            _controller.nextPage();
                            log('Move to interests');
                            context.read<ChoicesCubit>().fromWhereToInterest();
                            // change question
                            // show tally
                            // disable button
                          }
                        : choices.interests.length == 3
                            ? () {
                                _controller.nextPage();
                                // GET ORGANISATION AND NAVIGATE
                              }
                            : () {},
              ),
            );
          },
        );
      },
    );
  }
}
