import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/auth/cubit/auth_cubit.dart';

import 'package:givt_app_kids_web/shared/widgets/back_button.dart'
    as givt_widgets;
import 'package:givt_app_kids_web/shared/widgets/logout_button.dart';

class QuizScaffold extends StatelessWidget {
  const QuizScaffold(
      {required this.flexChildren, required this.fab, super.key});
  final Widget fab;
  final List<Widget> flexChildren;

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthCubit>().state;
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
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
                  children: flexChildren,
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 30,
              child: givt_widgets.BackButton(
                pageName: Pages.quizWhere.name,
              ),
            ),
            if (authState is LoggedInState)
              Positioned(
                top: 30,
                right: 30,
                child: LogoutButton(
                  pageName: Pages.quizWhere.name,
                ),
              ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: fab);
  }
}
