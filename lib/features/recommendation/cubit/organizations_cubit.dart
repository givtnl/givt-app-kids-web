import 'dart:ui';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:givt_app_kids_web/features/recommendation/models/organization.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';
import 'package:givt_app_kids_web/features/recommendation/repository/organizations_repository.dart';

part 'organizations_state.dart';

class OrganizationsCubit extends Cubit<OrganizationsState> {
  OrganizationsCubit() : super(const OrganizationsInitialState());

  Future<void> getRecommendedOrganizations({
    required Tag location,
    required List<Tag> interests,
    Duration fakeComputingExtraDelay = Duration.zero,
  }) async {
    emit(const OrganizationsFetchingState());
    await Future.delayed(fakeComputingExtraDelay);
    final organizationsRepository = OrganizationsRepository();
    try {
      final response =
          await organizationsRepository.getRecommendedOrganizations(
              location: location, interests: interests);

      emit(OrganizationsFetchedState(
        organizations: response,
      ));

      emit(OrganizationsOverviewState(
        organizations: response,
      ));
    } catch (error) {
      emit(OrganizationsExternalErrorState(
        errorMessage: error.toString(),
      ));
    }
  }

  void flipOrganization(Organization organization) {
    if (state is OrganizationsOverviewState) {
      final currentFlippedOrganization =
          (state as OrganizationsOverviewState).flippedOrganization;
      emit(OrganizationsOverviewState(
        organizations: state.organizations,
        flippedOrganization:
            currentFlippedOrganization == organization ? null : organization,
      ));
    }
  }

  void showOrganizationDetails({
    required Organization organization,
    bool isDonateMode = false,
  }) {
    if (state is OrganizationsOverviewState ||
        state is OrganizationDetailesState) {
      emit(OrganizationDetailesState(
        organizations: state.organizations,
        selectedOrganisation: organization,
        isDonateMode: isDonateMode,
      ));
    }
  }

  void showOrganizationsOverview() {
    if (state is OrganizationDetailesState) {
      emit(OrganizationsOverviewState(
        organizations: state.organizations,
      ));
    }
  }

  Future<void> getRecommendedOrganizationsTEST() async {
    return await getRecommendedOrganizations(
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
