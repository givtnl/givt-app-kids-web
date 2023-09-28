import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/core/app/app_config.dart';
import 'package:givt_app_kids_web/core/app/app_router.dart';
import 'package:givt_app_kids_web/core/injection/injection.dart';
import 'package:givt_app_kids_web/features/auth/cubit/auth_cubit.dart';
import 'package:givt_app_kids_web/features/profiles/cubit/profiles_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/choices/cubit/choices_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/organisations/cubit/organisations_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/quiz/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';

class GivtApp extends StatelessWidget {
  final AppConfig config;
  const GivtApp(this.config, {super.key});

  @override
  Widget build(BuildContext context) {
    AnalyticsHelper.init(config.amplitudePublicKey);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(getIt()),
        ),
        BlocProvider<ProfilesCubit>(
          create: (BuildContext context) => ProfilesCubit(getIt()),
        ),
        BlocProvider<OrganisationsCubit>(
          create: (BuildContext context) => OrganisationsCubit(getIt()),
        ),
        BlocProvider<QuizCubit>(
          create: (BuildContext context) => QuizCubit(getIt()),
        ),
        BlocProvider<ChoicesCubit>(
          create: (BuildContext context) => ChoicesCubit(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Givt Kids',
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 62, 73, 112),
            fontFamily: "Raleway"),
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
      ),
    );
  }
}
