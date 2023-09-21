import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/app_router.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/choices-cubit/choices_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/quiz_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/organizations_cubit.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';
import 'package:givt_app_kids_web/utils/api_helper.dart';
import 'app_config.dart';

class GivtApp extends StatelessWidget {
  final AppConfig config;
  const GivtApp(this.config, {super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    ApiHelper.apiURL = config.apiBaseUrl;
    AnalyticsHelper.init(config.amplitudePublicKey);

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
