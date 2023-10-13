import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/profiles/widgets/profile_wallet_button.dart';
import 'package:givt_app_kids_web/features/recommendation/tags/cubit/tags_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/tags/models/tag.dart';
import 'package:givt_app_kids_web/features/recommendation/tags/widgets/location_card.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/recommendation_givy_bubble.dart';
import 'package:givt_app_kids_web/shared/widgets/givt_primary_elevated_button.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:givt_app_kids_web/shared/widgets/back_button.dart'
    as givt_widgets;

class LocationSelectionScreen extends StatelessWidget {
  const LocationSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final anchorSize = size.aspectRatio > 1 ? size.width : size.height;
    return BlocBuilder<TagsCubit, TagsState>(
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
                        height: size.height * 0.10,
                      ),
                      RecommendationGivyBubble(
                        text: state is TagsStateFetching
                            ? 'Loading...'
                            : 'Where do you want to help?',
                      ),
                      SizedBox(
                        height: size.height * 0.10,
                      ),
                      if (state is TagsStateFetching)
                        Center(
                          child: LoadingAnimationWidget.waveDots(
                              color: const Color(0xFF54A1EE),
                              size: anchorSize * 0.2),
                        ),
                      if (state is TagsStateFetched)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: state.locations.reversed
                                .map((item) => LocationCard(
                                      location: item,
                                      width: anchorSize * 0.25,
                                      isSelected:
                                          item == state.selectedLocation,
                                      onPressed: () {
                                        context
                                            .read<TagsCubit>()
                                            .selectLocation(location: item);
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
                  pageName: Pages.locationSelection.name,
                ),
              ),
              Positioned(
                top: 30,
                right: 30,
                child: ProfileWalletButton(
                  pageName: Pages.locationSelection.name,
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
              onPressed: state is TagsStateFetched &&
                      state.selectedLocation != const Tag.empty()
                  ? () {
                      AnalyticsHelper.logEvent(
                        eventName: AmplitudeEvent.nextToInterestsPressed,
                        eventProperties: {
                          'location': state.selectedLocation.displayText,
                          'page_name': Pages.locationSelection.name,
                        },
                      );

                      context.pushNamed(
                        Pages.interestsSelection.name,
                        extra: state,
                      );
                      context.read<TagsCubit>().selectLocation(
                            location: const Tag.empty(),
                            logAmplitude: false,
                          );
                    }
                  : null,
            ),
          ),
        );
      },
    );
  }
}
