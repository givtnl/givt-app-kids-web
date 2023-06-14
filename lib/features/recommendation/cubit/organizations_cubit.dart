import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:givt_app_kids_web/features/recommendation/models/organization.dart';
import 'package:givt_app_kids_web/features/recommendation/repository/organizations_repository.dart';

part 'organizations_state.dart';

class OrganizationsCubit extends Cubit<OrganizationsState> {
  OrganizationsCubit() : super(const OrganizationsInitialState());

  Future<void> fetchOrganizations() async {
    emit(const OrganizationsFetchingState());
    final organizationsRepository = OrganizationsRepository();
    try {
      final response = await organizationsRepository.fetchOrganizations();
      emit(OrganizationsFetchedState(
        organizations: response,
      ));
    } catch (error) {
      emit(OrganizationsExternalErrorState(
        errorMessage: error.toString(),
      ));
    }
  }
}
