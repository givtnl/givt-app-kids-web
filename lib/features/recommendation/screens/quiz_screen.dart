import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/models/quiz_question.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/fab_recomendation.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givy_bubble.dart';

class WhereScreen extends StatelessWidget {
  WhereScreen({super.key});
  static const String routeName = "/quiz-where";
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    QuizQuestion whereQuestions = QuizQuestion.whereDoYouWantToHelp;
    QuizQuestion helpQuestions = QuizQuestion.helpPeople;
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
        child: Flex(
          direction: Axis.vertical,
          children: [
            Spacer(),
            Flexible(
              flex: 3,
              child: GivyBubble(
                text: whereQuestions.question,
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
                items: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: whereQuestions.options
                          .map((item) => Container(
                                height: size.height * 0.3,
                                width: size.width * 0.25,
                                padding: EdgeInsets.all(size.width * 0.005),
                                child: Card(
                                    elevation: 25,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: Color(0XFFFAF4D8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(item.image),
                                        Text(
                                          item.title,
                                          style: TextStyle(
                                              color: Color(0xFF405A66),
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    )),
                              ))
                          .toList()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 200),
                    child: GridView.count(
                      childAspectRatio: 2,
                      crossAxisCount: 4,
                      children: helpQuestions.options
                          .map((item) => SizedBox(
                              width: 100,
                              child: Card(
                                  child: Row(
                                children: [
                                  Text(item.title),
                                  SvgPicture.asset(item.image),
                                ],
                              ))))
                          .toList(),

                      // widget with results
                    ),
                  )
                ]),
            Spacer(flex: 4),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RecommendationFAB(
        text: 'Next',
        onClicked: () {
          _controller.nextPage();
          // if (state is QuizWhere) {
          //   context.read<QuizCubit>().nextInterests();
          // }
        },
      ),
    );
  }
}
