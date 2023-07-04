import 'package:givt_app_kids_web/features/recommendation/models/organization.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';
import 'package:givt_app_kids_web/features/recommendation/repository/organizations_data_provider.dart';

class OrganizationsRepository {
  Future<List<Organization>> getRecommendedOrganizations(
      List<Tag> inputTags) async {
    final dataProvider = OrganizationsDataProvider();
    final response = await dataProvider.getRecommendedOrganizations(inputTags);

    List<Organization> result = [];
    for (final organizationMap in response) {
      result.add(Organization.fromMap(organizationMap));
    }
    return result;
  }
}
