import 'dart:developer';

import 'package:givt_app_kids_web/core/network/network.dart';
import 'package:givt_app_kids_web/features/recommendation/tags/models/tag.dart';

mixin TagsRepository {
  Future<List<Tag>> fetchTags();
}

class TagsRepositoryImpl with TagsRepository {
  TagsRepositoryImpl(
    this._apiService,
  );

  final APIService _apiService;

  @override
  Future<List<Tag>> fetchTags() async {
    final response = await _apiService.fetchTags();

    List<Tag> result = [];
    for (final tagMap in response) {
      var tag = Tag.fromMap(tagMap);
      result.add(tag);
      log(tag.displayText);
    }
    return result;
  }
}
