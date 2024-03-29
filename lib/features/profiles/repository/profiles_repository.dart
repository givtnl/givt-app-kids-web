import 'package:givt_app_kids_web/core/network/network.dart';
import 'package:givt_app_kids_web/features/profiles/models/profile.dart';

mixin ProfilesRepository {
  Future<List<Profile>> fetchProfiles(String parentGuid);
}

class ProfilesRepositoryImpl with ProfilesRepository {
  ProfilesRepositoryImpl(
    this._apiService,
  );

  final APIService _apiService;

  @override
  Future<List<Profile>> fetchProfiles(String parentGuid) async {
    final response = await _apiService.fetchProfiles(parentGuid);

    List<Profile> result = [];
    for (final profileMap in response) {
      result.add(Profile.fromMap(profileMap));
    }
    return result;
  }
}
