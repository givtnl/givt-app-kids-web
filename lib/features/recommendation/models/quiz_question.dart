import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';

class QuizQuestion {
  final String question;
  final List<Tag> options;

  QuizQuestion({
    required this.question,
    required this.options,
  });
}
