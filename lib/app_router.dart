import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/features/parental_approval/trial_screen.dart';
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
            path: TrialApproval.routeName,
            name: TrialApproval.routeName,
            builder: (context, state) {
              return TrialApproval(
                decision: state.uri.queryParameters['decision'] ?? '',
                kidGUID: state.uri.queryParameters['kidGUID'] ?? '',
                transactionId: state.uri.queryParameters['transactionId'] ?? '',
              );
            }),
      ]);
}
