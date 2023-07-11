import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/choices-cubit/choices_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/organizations_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/screens/organizations_screen.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/fab_recomendation.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givy_bubble.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_interests_tally.dart';
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
    bool _tooNarrow = (MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .orientation ==
            Orientation.portrait) ||
        (MediaQuery.of(context).size.width < 850);
    final anchorSize = MediaQuery.of(context).size.aspectRatio > 1
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
    // Size size = MediaQuery.of(context).size;
    // log('we are on question ${context.watch<ChoicesCubit>().state.questionIndex}');

    return BlocListener<OrganizationsCubit, OrganizationsState>(
      listener: (context, state) {
        if (state is OrganizationsFetchedState) {
          Navigator.pushNamed(context, OrganizationsScreen.routeName);
        }
      },
      child: BlocBuilder<QuizCubit, QuizState>(
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
                      extraChild: choices is InterestsSelected
                          ? Tally(
                              size: anchorSize, tally: choices.interests.length)
                          : null,
                    ),
                  ),
                  CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.7,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        scrollDirection: Axis.vertical,
                        scrollPhysics: NeverScrollableScrollPhysics(),
                      ),
                      items: state is QuizLoading
                          ? [
                              Center(
                                child: LoadingAnimationWidget.waveDots(
                                    color: Color(0xFF54A1EE),
                                    size: anchorSize * 0.2),
                              )
                            ]
                          : state.questions.isEmpty
                              ? [SizedBox()]
                              : [
                                  LocationViewport(
                                    narrow: _tooNarrow,
                                    options: state.questions[0].options,
                                    size: anchorSize,
                                  ),
                                  InterestsViewPort(
                                      narrow: _tooNarrow,
                                      options: state.questions[1].options,
                                      size: anchorSize),
                                  Center(
                                    child: LoadingAnimationWidget.waveDots(
                                        color: Color(0xFF54A1EE),
                                        size: anchorSize * 0.2),
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
                              context
                                  .read<ChoicesCubit>()
                                  .fromWhereToInterest();
                            }
                          : choices.interests.length == 3
                              ? () {
                                  _controller.nextPage();
                                  context
                                      .read<OrganizationsCubit>()
                                      .getRecommendedOrganizations(
                                        location: choices.location,
                                        interests: choices.interests,
                                        // fakeComputingExtraDelay:
                                        //     const Duration(seconds: 2),
                                      );
                                }
                              : () {},
                ),
              );
            },
          );
        },
      ),
    );
  }
}
