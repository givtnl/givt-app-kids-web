import 'dart:developer';

import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';
import 'package:givt_app_kids_web/features/recommendation/repository/tags_data_provider.dart';

class TagsRepository {
  Future<List<Tag>> fetchTags() async {
    final dataProvider = TagsDataProvider();
    final response = await dataProvider.fetchTags();

    List<Tag> result = [];
    for (final tagMap in response) {
      var tag = Tag.fromMap(tagMap);
      result.add(tag);
      log('${tag.displayText}');
    }
    return result;
  }
}
