import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/fab_recomendation.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givy_bubble.dart';

class WhereScreen extends StatelessWidget {
  WhereScreen({super.key});
  static const String routeName = "/quiz-where";
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<QuizCubit, QuizState>(
      listener: (context, state) {
        // TODO: implement listener
      },
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
            child: Column(
              children: [
                GivyBubble(
                  text: state.questions[0].question,
                ),
                CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: size.height * 0.8,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.vertical,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                    ),
                    items: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: state.questions[0].options
                              .map((item) => Card(child: Text(item['title']!)))
                              .toList()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 200),
                        child: GridView.count(
                          childAspectRatio: 2,
                          crossAxisCount: 4,
                          children: state.questions[1].options
                              .map((item) => SizedBox(
                                  width: 100,
                                  child: Card(child: Text(item['title']!))))
                              .toList(),
                        ),
                      )
                    ]),
                Spacer(flex: 1),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
      },
    );
  }
}
