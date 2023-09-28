import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/core/injection/injection.dart';
import 'package:givt_app_kids_web/features/auth/screens/login_screen.dart';
import 'package:givt_app_kids_web/features/parental_approval/bloc/decision_bloc.dart';
import 'package:givt_app_kids_web/features/parental_approval/decision_screen.dart';
import 'package:givt_app_kids_web/features/profiles/screens/profile_selection_screen.dart';
import 'package:givt_app_kids_web/features/recommendation/screens/organisation_details_screen.dart';
import 'package:givt_app_kids_web/features/recommendation/screens/organisations_screen.dart';
import 'package:givt_app_kids_web/features/recommendation/screens/quiz_screen.dart';
import 'package:givt_app_kids_web/features/recommendation/screens/start_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;
  static final GoRouter _router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          path: Pages.start.path,
          name: Pages.start.name,
          builder: (context, state) => const StartScreen(),
        ),
        GoRoute(
          path: Pages.organisations.path,
          name: Pages.organisations.name,
          builder: (context, state) => const OrganisationsScreen(),
        ),
        GoRoute(
          path: Pages.organisationDetails.path,
          name: Pages.organisationDetails.name,
          builder: (context, state) => const OrganisationDetailsScreen(),
        ),
        GoRoute(
          path: Pages.quizWhere.path,
          name: Pages.quizWhere.name,
          builder: (context, state) => WhereScreen(),
        ),
        GoRoute(
          path: Pages.login.path,
          name: Pages.login.name,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: Pages.profileSelection.path,
          name: Pages.profileSelection.name,
          builder: (context, state) => const ProfileSelectionScreen(),
        ),
        GoRoute(
            path: Pages.parentDecision.path,
            name: Pages.parentDecision.name,
            builder: (context, state) {
              final String kidName =
                  state.uri.queryParameters['kidName']?.replaceAll('?', '') ??
                      '';
              final String donationId = state
                      .uri.queryParameters['transactionId']
                      ?.replaceAll('?', '') ??
                  '';
              final String decision =
                  state.uri.queryParameters['decision']?.replaceAll('?', '') ??
                      '';
              final childId =
                  state.uri.queryParameters['kidGUID']?.replaceAll('?', '') ??
                      '';
              final String organisationName = state
                      .uri.queryParameters['organisationName']
                      ?.replaceAll('?', '') ??
                  '';
              return BlocProvider(
                create: (context) => DecisionBloc(getIt())
                  ..add(DecisionInit(
                    donationId: donationId,
                    childId: childId,
                    decision: decision.contains('true'),
                  )),
                child: DecisionApproval(
                  decision: decision.contains('true'),
                  kidGUID: childId,
                  transactionId: donationId,
                  kidName: kidName,
                  organisationName: organisationName,
                ),
              );
            }),
      ]);
}
