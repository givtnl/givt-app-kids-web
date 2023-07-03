class QuizQuestion {
  final String question;
  final List<Map<String, String>> options;

  QuizQuestion({
    required this.question,
    required this.options,
  });

  static QuizQuestion whereDoYouWantToHelp = QuizQuestion(
    question: 'Where would you like to help?',
    options: [
      {
        'title': 'In my community',
        'image': 'images/flags/netherlands.png',
      },
      {
        'title': 'In my country',
        'image': 'images/flags/india.png',
      },
      {
        'title': 'All around the world',
        'image': 'images/flags/question.png',
      },
    ],
  );
  static QuizQuestion helpPeople =
      QuizQuestion(question: 'I want to help people...', options: [
    {
      'title': 'learn to read',
      'image': 'images/flags/netherlands.png',
    },
    {
      'title': 'protect animals',
      'image': 'images/flags/india.png',
    },
    {
      'title': 'stay healthy',
      'image': 'images/flags/question.png',
    },
    {
      'title': 'care for children',
      'image': '',
    },
    {
      'title': 'go to school',
      'image': 'images/flags/question.png',
    },
    {
      'title': 'with disabilities',
      'image': 'images/flags/question.png',
    },
    {
      'title': 'that are homeless',
      'image': 'images/flags/question.png',
    },
    {
      'title': 'get food',
      'image': 'images/flags/question.png',
    },
    {
      'title': 'find a home',
      'image': 'images/flags/question.png',
    },
    {
      'title': 'protect the forests',
      'image': 'images/flags/question.png',
    },
    {
      'title': 'after a disaster',
      'image': 'images/flags/question.png',
    },
    {
      'title': 'clean oceans',
      'image': 'images/flags/question.png',
    },
  ]);
}
