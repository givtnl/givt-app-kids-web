import 'dart:ui';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/recommendation/organisations/models/organisation.dart';
import 'package:givt_app_kids_web/features/recommendation/organisations/repositories/organisations_repository.dart';
import 'package:givt_app_kids_web/features/recommendation/tags/models/tag.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';

part 'organisations_state.dart';

class OrganisationsCubit extends Cubit<OrganisationsState> {
  OrganisationsCubit(this._organisationsRepository)
      : super(const OrganisationsInitialState());

  final OrganisationsRepository _organisationsRepository;

  Future<void> getRecommendedOrganisations({
    required Tag location,
    required List<Tag> interests,
    Duration fakeComputingExtraDelay = Duration.zero,
  }) async {
    emit(const OrganisationsFetchingState());

    await Future.delayed(fakeComputingExtraDelay);

    try {
      AnalyticsHelper.logEvent(
        eventName: AmplitudeEvent.nextToCharitiesPressed,
        eventProperties: {
          'interests': '${interests.map((e) => e.displayText).toList()}',
          'page_name': Pages.interestsSelection.name,
        },
      );
      final response =
          await _organisationsRepository.getRecommendedOrganisations(
              location: location, interests: interests);

      emit(OrganisationsFetchedState(
        organisations: response,
      ));

      emit(OrganisationsOverviewState(
        organisations: response,
      ));
    } catch (error) {
      emit(OrganisationsExternalErrorState(
        errorMessage: error.toString(),
      ));
    }
  }

  void flipOrganisation(Organisation organisation) {
    if (state is OrganisationsOverviewState) {
      final currentFlippedOrganisation =
          (state as OrganisationsOverviewState).flippedOrganisation;
      emit(OrganisationsOverviewState(
        organisations: state.organisations,
        flippedOrganisation:
            currentFlippedOrganisation == organisation ? null : organisation,
      ));
      AnalyticsHelper.logEvent(
          eventName: AmplitudeEvent.charityCardPressed,
          eventProperties: {
            'charity_name': organisation.name,
            'page_name': Pages.organisations.name,
          });
    }
  }

  void showOrganisationDetails({
    required Organisation organisation,
    bool isDonateMode = false,
  }) {
    if (state is OrganisationsOverviewState ||
        state is OrganisationDetailesState) {
      emit(OrganisationDetailesState(
        organisations: state.organisations,
        selectedOrganisation: organisation,
        isDonateMode: isDonateMode,
      ));
      if (isDonateMode) {
        AnalyticsHelper.logEvent(
          eventName: AmplitudeEvent.donatePressed,
          eventProperties: {
            "charity_name": organisation.name,
            'page_name': Pages.organisationDetails.name,
          },
        );
      } else {
        AnalyticsHelper.logEvent(
          eventName: AmplitudeEvent.learnMorePressed,
          eventProperties: {
            'charity_name': organisation.name,
            'page_name': Pages.organisations.name,
          },
        );
      }
    }
  }

  void showOrganisationsOverview() {
    if (state is OrganisationDetailesState) {
      emit(OrganisationsOverviewState(
        organisations: state.organisations,
      ));
    }
  }

  Future<void> getRecommendedOrganisationsTEST() async {
    return await getRecommendedOrganisations(
      fakeComputingExtraDelay: const Duration(seconds: 0),
      location: const Tag(
        area: '',
        color: Color(0xFF285C92),
        key: 'USA',
        displayText: '',
        pictureUrl: '',
        type: TagType.LOCATION,
      ),
      interests: [
        const Tag(
          key: 'CLEANOCEANS',
          area: 'ENVIRONMENT',
          color: Color(0xFF00845A),
          displayText: '',
          pictureUrl: '',
          type: TagType.INTERESTS,
        ),
        const Tag(
          key: 'GETFOOD',
          area: 'BASIC',
          color: Color(0xFFFAB63E),
          displayText: '',
          pictureUrl: '',
          type: TagType.INTERESTS,
        ),
        const Tag(
          key: 'CAREFORCHILDREN',
          area: 'HEALTH',
          color: Color(0xFF7AAA35),
          displayText: '',
          pictureUrl: '',
          type: TagType.INTERESTS,
        ),
      ],
    );
  }
}
