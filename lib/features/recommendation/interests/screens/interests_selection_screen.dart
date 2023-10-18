import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/profiles/widgets/profile_wallet_button.dart';
import 'package:givt_app_kids_web/features/recommendation/interests/cubit/interests_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/interests/widgets/interest_card.dart';
import 'package:givt_app_kids_web/features/recommendation/organisations/cubit/organisations_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/recommendation_givy_bubble.dart';
import 'package:givt_app_kids_web/features/recommendation/interests/widgets/interests_tally.dart';
import 'package:givt_app_kids_web/shared/widgets/givt_primary_elevated_button.dart';

import 'package:givt_app_kids_web/shared/widgets/back_button.dart'
    as givt_widgets;
import 'package:givt_app_kids_web/utils/analytics_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class InterestsSelectionScreen extends StatelessWidget {
  const InterestsSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final anchorSize = size.aspectRatio > 1 ? size.width : size.height;
    return BlocConsumer<OrganisationsCubit, OrganisationsState>(
      listener: (context, organisationState) {
        if (organisationState is OrganisationsFetchedState) {
          context.pushNamed(Pages.organisations.name);
          AnalyticsHelper.logEvent(
            eventName: AmplitudeEvent.charitiesShown,
            eventProperties: {
              'charities_names': organisationState.organisations
                  .map((e) => e.name)
                  .toList()
                  .toString(),
              'page_name': Pages.organisations.name,
            },
          );
        }
      },
      builder: (context, organisationState) {
        return BlocBuilder<InterestsCubit, InterestsState>(
          builder: (context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'images/gradient.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          RecommendationGivyBubble(
                            text:
                                organisationState is OrganisationsFetchingState
                                    ? 'Loading...'
                                    : 'I want to help people...',
                            extraChild:
                                organisationState is! OrganisationsFetchingState
                                    ? InterestsTally(
                                        size: anchorSize,
                                        tally: state.selectedInterests.length,
                                      )
                                    : null,
                          ),
                          SizedBox(
                            height: size.height * 0.07,
                          ),
                          if (organisationState is OrganisationsFetchingState)
                            Center(
                              child: LoadingAnimationWidget.waveDots(
                                  color: const Color(0xFF54A1EE),
                                  size: anchorSize * 0.2),
                            ),
                          if (organisationState is! OrganisationsFetchingState)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.1),
                              child: GridView.count(
                                childAspectRatio: 2,
                                crossAxisCount: 4,
                                shrinkWrap: true,
                                children: state.interests
                                    .map((item) => InterestCard(
                                          interest: item,
                                          width: anchorSize * 0.30,
                                          isSelected: state.selectedInterests
                                              .contains(item),
                                          onPressed: () {
                                            context
                                                .read<InterestsCubit>()
                                                .selectInterest(item);
                                          },
                                        ))
                                    .toList(),
                              ),
                            ),
                          SizedBox(
                            height: size.height * 0.10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 30,
                    child: givt_widgets.BackButton(
                      pageName: Pages.interestsSelection.name,
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 30,
                    child: ProfileWalletButton(
                      pageName: Pages.interestsSelection.name,
                    ),
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: GivtPrimaryElevatedButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                  text: 'Next',
                  onPressed: state.selectedInterests.length ==
                              InterestsState.maxInterests &&
                          organisationState is! OrganisationsFetchingState
                      ? () {
                          context
                              .read<OrganisationsCubit>()
                              .getRecommendedOrganisations(
                                location: state.location,
                                interests: state.selectedInterests,
                                fakeComputingExtraDelay:
                                    const Duration(seconds: 1),
                              );
                          context
                              .read<InterestsCubit>()
                              .clearSelectedInterests();
                        }
                      : null,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
