import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/quiz_cubit.dart';
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

    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
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
                    text: state.questions.isEmpty
                        ? "Sorry, something is off..."
                        : state.questions[0].question,
                  ),
                ),
                state.questions.isEmpty
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: state.questions[0].options
                                    .map((item) => Container(
                                          height: size.height * 0.3,
                                          width: size.width * 0.25,
                                          padding: EdgeInsets.all(
                                              size.width * 0.005),
                                          child: Card(
                                              elevation: 25,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              color: Color(0XFFFAF4D8),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.network(
                                                      item.pictureUrl),
                                                  Text(
                                                    item.displayText,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF405A66),
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                ],
                                              )),
                                        ))
                                    .toList()),
                            SizedBox(
                              height: size.height * 0.7,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.1),
                                  child: GridView.count(
                                    childAspectRatio: 2,
                                    crossAxisCount: 4,
                                    shrinkWrap: true,
                                    children: state.questions[1].options
                                        .map((item) => Container(
                                            margin: EdgeInsets.all(
                                                size.width * 0.003),
                                            child: Card(
                                                elevation: 25,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                color: Color(0XFFFAF4D8),
                                                child: Stack(
                                                  children: [
                                                    Radio(
                                                        value: 0,
                                                        groupValue: 1,
                                                        onChanged: (int) {}),
                                                    Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          SizedBox(
                                                            width: size.width *
                                                                0.08,
                                                            child: Text(
                                                              item.displayText,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF405A66),
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: SvgPicture
                                                                .network(
                                                              item.pictureUrl,
                                                              width:
                                                                  size.width *
                                                                      0.055,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ))))
                                        .toList(),

                                    // widget with results
                                  ),
                                ),
                              ),
                            )
                          ]),
                Spacer(flex: 4),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: RecommendationFAB(
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
