import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/organizations_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/models/quiz_question.dart';
import 'package:givt_app_kids_web/features/recommendation/screens/organizations_screen.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/fab_recomendation.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givy_bubble.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/organizations_loading_page.dart';

class WhereScreen extends StatefulWidget {
  const WhereScreen({super.key});
  static const String routeName = "/quiz-where";
  static const _numPages = 3;

  @override
  State<WhereScreen> createState() => _WhereScreenState();
}

class _WhereScreenState extends State<WhereScreen> {
  final CarouselController _controller = CarouselController();

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    QuizQuestion whereQuestions = QuizQuestion.whereDoYouWantToHelp;
    QuizQuestion helpQuestions = QuizQuestion.helpPeople;
    return BlocListener<OrganizationsCubit, OrganizationsState>(
      listener: (context, state) {
        if (state is OrganizationsFetchedState) {
          Navigator.pushNamed(context, OrganizationsScreen.routeName);
        }
      },
      child: Scaffold(
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
                text: _currentPage == WhereScreen._numPages - 1
                    ? 'Let me think ...'
                    : whereQuestions.question,
              ),
              CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: size.height * 0.8,
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
                                        children: [
                                          SvgPicture.asset(item.image),
                                          Text(item.title)
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
                    ),
                    const OrganizationsLoadingPage(),
                  ]),
              Spacer(flex: 1),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: RecommendationFAB(
          text: 'Next',
          onClicked: () {
            _controller.nextPage();
            setState(() {
              _currentPage++;
              if (_currentPage == WhereScreen._numPages - 1) {
                //TODO replace with real input
                context
                    .read<OrganizationsCubit>()
                    .getRecommendedOrganizationsTEST();
              }
            });
            // if (state is QuizWhere) {
            //   context.read<QuizCubit>().nextInterests();
            // }
          },
        ),
      ),
    );
  }
}
