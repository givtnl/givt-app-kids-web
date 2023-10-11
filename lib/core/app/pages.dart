enum Pages {
  start(path: '/', name: 'START'),
  locationSelection(path: '/location-selection', name: 'LOCATION_SELECTION'),
  interestsSelection(path: '/interests-selection', name: 'INTERESTS_SELECTION'),
  organisations(path: '/organisations', name: 'ORGANISATIONS'),
  organisationDetails(
      path: '/organisation-details', name: 'ORGANISATION_DETAILS'),
  parentDecision(path: '/parent-decision', name: 'PARENT_DECISION'),
  login(path: '/login', name: 'LOGIN'),
  profileSelection(path: '/profile-selection', name: 'PROFILE_SELECTION'),
  profileSelectionOverlay(
      path: '/profile-selection-overlay', name: 'PROFILE_SELECTION_OVERLAY'),
  ;

  final String path;
  final String name;

  const Pages({
    required this.path,
    required this.name,
  });
}
