import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/choices-cubit/choices_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/organizations_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/screens/organizations_screen.dart';
import 'package:givt_app_kids_web/features/recommendation/screens/start_screen.dart';
import 'package:givt_app_kids_web/features/recommendation/screens/quiz_screen.dart';
import 'app_config.dart';

class GivtApp extends StatelessWidget {
  final AppConfig config;
  const GivtApp(this.config, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrganizationsCubit>(
          create: (BuildContext context) => OrganizationsCubit(),
        ),
        BlocProvider<QuizCubit>(
          create: (BuildContext context) => QuizCubit(),
        ),
        BlocProvider<ChoicesCubit>(
          create: (BuildContext context) => ChoicesCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Givt Kids',
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 62, 73, 112),
            fontFamily: "Raleway"),
        home: const StartScren(),
        routes: {
          WhereScreen.routeName: (context) => WhereScreen(),
          OrganizationsScreen.routeName: (context) => OrganizationsScreen(),
        },
      ),
    );
  }
}
