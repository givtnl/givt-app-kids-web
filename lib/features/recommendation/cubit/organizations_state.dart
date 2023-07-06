part of 'organizations_cubit.dart';

abstract class OrganizationsState extends Equatable {
  const OrganizationsState({required this.organizations});

  final List<Organization> organizations;

  @override
  List<Object?> get props => [organizations];
}

class OrganizationsInitialState extends OrganizationsState {
  const OrganizationsInitialState() : super(organizations: const []);
}

class OrganizationsFetchingState extends OrganizationsState {
  const OrganizationsFetchingState() : super(organizations: const []);
}

class OrganizationsFetchedState extends OrganizationsState {
  const OrganizationsFetchedState({required super.organizations});
}

class OrganizationsOverviewState extends OrganizationsState {
  const OrganizationsOverviewState({
    required super.organizations,
    this.flippedOrganization,
  });

  final Organization? flippedOrganization;
  @override
  List<Object?> get props => [organizations, flippedOrganization];
}

class OrganizationDetailesState extends OrganizationsState {
  const OrganizationDetailesState({
    required super.organizations,
    required this.selectedOrganisation,
  });

  final Organization selectedOrganisation;

  @override
  List<Object?> get props => [organizations, selectedOrganisation];
}

class OrganizationsExternalErrorState extends OrganizationsState {
  const OrganizationsExternalErrorState({required this.errorMessage})
      : super(organizations: const []);

  final String errorMessage;

  @override
  List<Object?> get props => [organizations, errorMessage];
}
