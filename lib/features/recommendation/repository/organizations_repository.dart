import 'package:givt_app_kids_web/features/recommendation/models/organization.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';
import 'package:givt_app_kids_web/features/recommendation/repository/organizations_data_provider.dart';

class OrganizationsRepository {
  Future<List<Organization>> getRecommendedOrganizations({
    required Tag location,
    required List<Tag> interests,
  }) async {
    final dataProvider = OrganizationsDataProvider();
    final response = await dataProvider.getRecommendedOrganizations(
        location: location, interests: interests);

    List<Organization> result = [];
    for (final organizationMap in response) {
      final organization = Organization.fromMap(organizationMap);
      organization.tags.removeWhere((tag) =>
          !interests.contains(tag) && tag.type == TagType.INTERESTS ||
          location.key != tag.key && tag.type == TagType.LOCATION);

      result.add(organization);
    }
    return result;
  }
}
