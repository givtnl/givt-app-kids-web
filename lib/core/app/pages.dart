enum Pages {
  start(path: '/', name: 'START'),
  organisations(path: '/organisations', name: 'ORGANISATIONS'),
  organisationDetails(
      path: '/organisation-details', name: 'ORGANISATION_DETAILS'),
  quizWhere(path: '/quiz-where', name: 'QUIZ_WHERE'),
  parentDecision(path: '/parent-decision', name: 'PARENT_DECISION'),

  login(path: '/login', name: 'LOGIN'),
  profileSelection(path: '/profile-selection', name: 'PROFILE_SELECTION'),
  // wallet(path: '/wallet', name: 'WALLET'),
  // camera(path: '/camera', name: 'CAMERA'),
  // success(path: '/success', name: 'SUCCESS'),
  // recommend(path: '/recommend', name: 'RECOMMEND'),
  // chooseAmountSlider(
  //     path: '/choose-amount-slider', name: 'CHOOSE_AMOUNT_SLIDER'),
  ;

  final String path;
  final String name;

  const Pages({
    required this.path,
    required this.name,
  });
}
