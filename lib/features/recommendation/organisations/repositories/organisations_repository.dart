import 'package:givt_app_kids_web/core/network/network.dart';
import 'package:givt_app_kids_web/features/recommendation/organisations/models/organisation.dart';
import 'package:givt_app_kids_web/features/recommendation/tags/models/tag.dart';

mixin OrganisationsRepository {
  Future<List<Organisation>> getRecommendedOrganisations({
    required Tag location,
    required List<Tag> interests,
  });
}

class OrganisationsRepositoryImpl with OrganisationsRepository {
  OrganisationsRepositoryImpl(
    this._apiService,
  );

  final APIService _apiService;

  @override
  Future<List<Organisation>> getRecommendedOrganisations(
      {required Tag location, required List<Tag> interests}) async {
    final response = await _apiService.getRecommendedOrganisations(
      {
        "range": location.key,
        "pageSize": 3,
        "tags": interests.map((interest) => interest.key).toList(),
      },
    );

    List<Organisation> result = [];
    for (final organisationMap in response) {
      final organisation = Organisation.fromMap(organisationMap);
      organisation.tags.removeWhere((tag) =>
          !interests.contains(tag) && tag.type == TagType.INTERESTS ||
          location.key != tag.key && tag.type == TagType.LOCATION);

      result.add(organisation);
    }
    return result;
  }
}
