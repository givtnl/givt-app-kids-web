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
    } catch (error) {
      emit(OrganizationsExternalErrorState(
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> getRecommendedOrganizationsTEST() async {
    return await getRecommendedOrganizations(
      location: const Tag(
        key: 'USA',
        displayText: '',
        pictureUrl: '',
        type: TagType.LOCATION,
      ),
      interests: [
        const Tag(
          key: 'CLEANOCEANS',
          displayText: '',
          pictureUrl: '',
          type: TagType.INTERESTS,
        ),
        const Tag(
          key: 'GETFOOD',
          displayText: '',
          pictureUrl: '',
          type: TagType.INTERESTS,
        ),
        const Tag(
          key: 'CAREFORCHILDREN',
          displayText: '',
          pictureUrl: '',
          type: TagType.INTERESTS,
        ),
      ],
    );
  }
}
