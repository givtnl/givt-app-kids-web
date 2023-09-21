import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/features/parental_approval/bloc/decision_bloc.dart';
import 'package:givt_app_kids_web/features/parental_approval/decision_screen.dart';
import 'package:givt_app_kids_web/features/recommendation/screens/organization_details_screen.dart';
import 'package:givt_app_kids_web/features/recommendation/screens/organizations_screen.dart';
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
          path: "/",
          name: '/',
          builder: (context, state) => const StartScren(),
        ),
        GoRoute(
          path: OrganizationsScreen.routeName,
          name: OrganizationsScreen.routeName,
          builder: (context, state) => const OrganizationsScreen(),
        ),
        GoRoute(
          path: OrganizationDetailsScreen.routeName,
          name: OrganizationDetailsScreen.routeName,
          builder: (context, state) => const OrganizationDetailsScreen(),
        ),
        GoRoute(
          path: WhereScreen.routeName,
          name: WhereScreen.routeName,
          builder: (context, state) => WhereScreen(),
        ),
        GoRoute(
            path: DecisionApproval.routeName,
            name: DecisionApproval.routeName,
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
              final String organizationName = state
                      .uri.queryParameters['organisationName']
                      ?.replaceAll('?', '') ??
                  '';
              return BlocProvider(
                create: (context) => DecisionBloc()
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
                  organizationName: organizationName,
                ),
              );
            }),
      ]);
}
