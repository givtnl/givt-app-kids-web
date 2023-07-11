// ignore_for_file: sized_box_for_whitespace

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/organizations_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/fab_recomendation.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givy_bubble.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/organization_item.dart';

class OrganizationsScreen extends StatelessWidget {
  const OrganizationsScreen({super.key});

  static const String routeName = "/organizations";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<OrganizationsCubit, OrganizationsState>(
      listener: (context, state) {
        log('OrganizationsCubit state changed on $state');
        if (state is OrganizationsExternalErrorState) {
          log(state.errorMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Cannot recommend organizations. Please try again later. ${state.errorMessage}",
                textAlign: TextAlign.center,
              ),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/gradient.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(),
                  GivyBubble(
                    text: state.organizations.isEmpty
                        ? 'Oops, something went wrong...'
                        : 'These charities fit your interests!',
                    small: true,
                  ),
                  Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: state.organizations
                        .map(
                          (organization) => OrganizationItem(
                            width:
                                (size.width * .8) / state.organizations.length,
                            height: size.height * .83,
                            organization: organization,
                            isFlipped: (state as OrganizationsOverviewState)
                                    .flippedOrganization ==
                                organization,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: state.organizations.isEmpty
                ? RecommendationFAB(
                    active: true,
                    text: 'Restart',
                    onClicked: () =>
                        Navigator.popUntil(context, (route) => route.isFirst))
                : null,
          ),
        );
      },
    );
  }
}
