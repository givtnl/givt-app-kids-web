part of 'organisations_cubit.dart';

abstract class OrganisationsState extends Equatable {
  const OrganisationsState({required this.organisations});

  final List<Organisation> organisations;

  @override
  List<Object?> get props => [organisations];
}

class OrganisationsInitialState extends OrganisationsState {
  const OrganisationsInitialState() : super(organisations: const []);
}

class OrganisationsFetchingState extends OrganisationsState {
  const OrganisationsFetchingState() : super(organisations: const []);
}

class OrganisationsFetchedState extends OrganisationsState {
  const OrganisationsFetchedState({required super.organisations});
}

class OrganisationsOverviewState extends OrganisationsState {
  const OrganisationsOverviewState({
    required super.organisations,
    this.flippedOrganisation,
  });

  final Organisation? flippedOrganisation;
  @override
  List<Object?> get props => [organisations, flippedOrganisation];
}

class OrganisationDetailesState extends OrganisationsOverviewState {
  const OrganisationDetailesState({
    required super.organisations,
    required this.selectedOrganisation,
    this.isDonateMode = false,
  });

  final Organisation selectedOrganisation;
  final bool isDonateMode;

  @override
  List<Object?> get props =>
      [organisations, selectedOrganisation, flippedOrganisation, isDonateMode];
}

class OrganisationsExternalErrorState extends OrganisationsState {
  const OrganisationsExternalErrorState({required this.errorMessage})
      : super(organisations: const []);

  final String errorMessage;

  @override
  List<Object?> get props => [organisations, errorMessage];
}
