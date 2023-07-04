class QuizQuestionOption {
  final String title;
  final String image;
  final String tag;

  QuizQuestionOption({
    required this.title,
    required this.image,
    required this.tag,
  });

  static QuizQuestionOption whereCommunity = QuizQuestionOption(
    title: 'In my community',
    image: 'images/community.svg',
    tag: 'STATE',
  );

  static QuizQuestionOption whereCountry = QuizQuestionOption(
    title: 'in my country',
    image: 'images/usa.svg',
    tag: 'USA',
  );

  static QuizQuestionOption whereWorld = QuizQuestionOption(
    title: 'all around the world',
    image: 'images/world.svg',
    tag: 'WORLDWIDE',
  );

  static QuizQuestionOption learnToRead = QuizQuestionOption(
    title: 'learn to read',
    image: 'images/learn.svg',
    tag: 'LEARNTOREAD',
  );

  static QuizQuestionOption helpAnimals = QuizQuestionOption(
    title: 'protect animals',
    image: 'images/panda.svg',
    tag: 'PROTECTANIMALS',
  );

  static QuizQuestionOption helpHealthy = QuizQuestionOption(
    title: 'stay healthy',
    image: 'images/healthy.svg',
    tag: 'STAYHEALTHY',
  );

  static QuizQuestionOption careForChildren = QuizQuestionOption(
    title: 'care for children',
    image: 'images/children.svg',
    tag: 'CAREFORCHILDREN',
  );

  static QuizQuestionOption goToSchool = QuizQuestionOption(
    title: 'go to school',
    image: 'images/school.svg',
    tag: 'GOTOSCHOOL',
  );

  static QuizQuestionOption withDisabilities = QuizQuestionOption(
    title: 'with disabilities',
    image: 'images/disabilities.svg',
    tag: 'WITHDISABILITIES',
  );

  static QuizQuestionOption thatAreHomeless = QuizQuestionOption(
    title: 'that are homeless',
    image: 'images/homeless.svg',
    tag: 'THATAREHOMELESS',
  );

  static QuizQuestionOption getFood = QuizQuestionOption(
    title: 'get food',
    image: 'images/food.svg',
    tag: 'GETFOOD',
  );

  static QuizQuestionOption findaHome = QuizQuestionOption(
    title: 'find a home',
    image: 'images/home.svg',
    tag: 'FINDAHOME',
  );

  static QuizQuestionOption protectForests = QuizQuestionOption(
    title: 'protect forests',
    image: 'images/tree.svg',
    tag: 'PROTECTFORESTS',
  );

  static QuizQuestionOption afteraDisaster = QuizQuestionOption(
    title: 'after a disaster',
    image: 'images/aid.svg',
    tag: 'AFTERADISASTER',
  );

  static QuizQuestionOption cleanOceans = QuizQuestionOption(
    title: 'clean oceans',
    image: 'images/ocean.svg',
    tag: 'CLEANOCEANS',
  );
}
