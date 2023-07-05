import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/fab_recomendation.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givy_bubble.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_interests_viewport.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_location_viewport.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/quiz_scaffold.dart';

class WhereScreen extends StatelessWidget {
  WhereScreen({super.key});
  static const String routeName = "/quiz-where";
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
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
                        : state.questions[0].question,
              ),
            ),
            state is QuizLoading
                ? CircularProgressIndicator()
                : state.questions.isEmpty
                    ? Spacer()
                    : CarouselSlider(
                        carouselController: _controller,
                        options: CarouselOptions(
                          height: size.height * 0.7,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          scrollDirection: Axis.vertical,
                          //scrollPhysics: NeverScrollableScrollPhysics(),
                        ),
                        items: [
                            LocationViewport(
                              options: state.questions[0].options,
                              size: size,
                            ),
                            InterestsViewPort(
                                options: state.questions[1].options,
                                size: size),
                            //TODO: LOADING ANIMATION BEFORE RESULTS
                          ]),
            Spacer(flex: 4),
          ],
          fab: RecommendationFAB(
            text: state is QuizStarted ? 'Next' : 'Restart',
            onClicked: () {
              if (state is QuizStarted == false) {
                Navigator.popUntil(context, (route) => route.isFirst);
              }
              _controller.nextPage();
              // if (state is QuizWhere) {
              //   context.read<QuizCubit>().nextInterests();
              // }
            },
          ),
        );
      },
    );
  }
}
