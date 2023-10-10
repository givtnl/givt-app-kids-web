// ignore_for_file: sized_box_for_whitespace

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/profiles/widgets/profile_wallet_button.dart';
import 'package:givt_app_kids_web/features/recommendation/organisations/cubit/organisations_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/fab_recomendation.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givy_bubble.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/organisation_item.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';
import 'package:go_router/go_router.dart';

import 'package:givt_app_kids_web/shared/widgets/back_button.dart'
    as givt_widgets;

class OrganisationsScreen extends StatelessWidget {
  const OrganisationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<OrganisationsCubit, OrganisationsState>(
      listener: (context, state) {
        log('OrganisationsCubit state changed on $state');
        if (state is OrganisationsExternalErrorState) {
          log(state.errorMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Cannot recommend organisations. Please try again later. ${state.errorMessage}",
                textAlign: TextAlign.center,
              ),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/gradient.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: EdgeInsets.only(top: size.height * 0.03),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GivyBubble(
                          text: state.organisations.isEmpty
                              ? 'Oops, something went wrong...'
                              : 'These charities fit your interests!',
                          small: true,
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: state.organisations
                                .map(
                                  (organisation) => OrganisationItem(
                                    width: (size.width * .8) /
                                        state.organisations.length,
                                    height: size.height * .85,
                                    organisation: organisation,
                                    isFlipped:
                                        (state as OrganisationsOverviewState)
                                                .flippedOrganisation ==
                                            organisation,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 30,
                child: givt_widgets.BackButton(
                  pageName: Pages.organisations.name,
                ),
              ),
              Positioned(
                top: 30,
                right: 30,
                child: ProfileWalletButton(
                  pageName: Pages.organisations.name,
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: state.organisations.isEmpty
              ? RecommendationFAB(
                  active: true,
                  text: 'Restart',
                  onClicked: () {
                    context.goNamed(Pages.start.name);
                    AnalyticsHelper.logEvent(
                        eventName: AmplitudeEvent.restartClicked);
                  })
              : null,
        );
      },
    );
  }
}
