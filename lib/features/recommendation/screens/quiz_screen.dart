import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/recommendation/choices/cubit/choices_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/organisations/cubit/organisations_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/quiz/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/fab_recomendation.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givy_bubble.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_interests_tally.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_interests_viewport.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_location_viewport.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_scaffold.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WhereScreen extends StatelessWidget {
  WhereScreen({super.key});
  static const String routeName = "/quiz-where";

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    bool _tooNarrow =
        (MediaQuery.of(context).orientation == Orientation.portrait) ||
            (MediaQuery.of(context).size.width < 850);
    final anchorSize = MediaQuery.of(context).size.aspectRatio > 1
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;

    return BlocListener<OrganisationsCubit, OrganisationsState>(
      listener: (context, state) {
        if (state is OrganisationsFetchedState) {
          context.pushNamed(Pages.organisations.name);
          AnalyticsHelper.logEvent(
              eventName: AmplitudeEvent.charitiesShown,
              eventProperties: {
                "charities":
                    state.organisations.map((e) => e.name).toList().toString(),
              });
        }
      },
      child: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          return BlocBuilder<ChoicesCubit, ChoicesState>(
            builder: (context, choices) {
              return QuizScaffold(
                flexChildren: [
                  const Spacer(),
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
                          context.goNamed(Pages.start.name);
                          AnalyticsHelper.logEvent(
                            eventName: AmplitudeEvent.restartClicked,
                          );
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
                                      .read<OrganisationsCubit>()
                                      .getRecommendedOrganisations(
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
