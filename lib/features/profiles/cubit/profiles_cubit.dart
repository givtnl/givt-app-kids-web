import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/features/profiles/models/profile.dart';
import 'package:givt_app_kids_web/features/profiles/repository/profiles_repository.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';

part 'profiles_state.dart';

class ProfilesCubit extends Cubit<ProfilesState> {
  ProfilesCubit(this._profilesRepositoy) : super(const ProfilesInitialState()) {
    AnalyticsHelper.setUserId(state.activeProfile.firstName);
  }

  final ProfilesRepository _profilesRepositoy;

  Future<void> fetchProfiles(String parentGuid) async {
    final activeProfileBalance = state.activeProfile.wallet.balance;
    emit(ProfilesLoadingState(
      profiles: state.profiles,
      activeProfileIndex: state.activeProfileIndex,
    ));
    try {
      final response = await _profilesRepositoy.fetchProfiles(parentGuid);

      var activeProfileNewBalance = state.activeProfileIndex >= 0 &&
              state.activeProfileIndex < response.length
          ? response[state.activeProfileIndex].wallet.balance
          : activeProfileBalance;

      if (activeProfileNewBalance < activeProfileBalance) {
        emit(ProfilesCountdownState(
            profiles: response,
            activeProfileIndex: state.activeProfileIndex,
            amount: activeProfileBalance - activeProfileNewBalance));
      } else {
        emit(ProfilesUpdatedState(
          profiles: response,
          activeProfileIndex: state.activeProfileIndex,
        ));
      }
    } catch (error) {
      emit(ProfilesExternalErrorState(
        errorMessage: error.toString(),
        activeProfileIndex: state.activeProfileIndex,
        profiles: state.profiles,
      ));
    }
  }

  void clearProfiles() {
    emit(const ProfilesInitialState());
  }

  void setActiveProfile(Profile profile) {
    final index = state.profiles.indexOf(profile);
    emit(ProfilesUpdatedState(
      profiles: state.profiles,
      activeProfileIndex: index,
    ));
  }
}
