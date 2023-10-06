import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/auth/cubit/auth_cubit.dart';

import 'package:givt_app_kids_web/features/profiles/cubit/profiles_cubit.dart';
import 'package:givt_app_kids_web/features/profiles/models/profile.dart';
import 'package:givt_app_kids_web/features/profiles/screens/profile_selection_screen.dart';
import 'package:givt_app_kids_web/features/profiles/widgets/profile_overlay_button.dart';
import 'package:givt_app_kids_web/features/profiles/widgets/profile_wallet_button.dart';
import 'package:givt_app_kids_web/shared/widgets/logout_button.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';
import 'package:go_router/go_router.dart';

class ProfileSelectionOverlayScreen extends StatefulWidget {
  const ProfileSelectionOverlayScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSelectionOverlayScreen> createState() =>
      _ProfileSelectionOverlayScreenState();
}

class _ProfileSelectionOverlayScreenState
    extends State<ProfileSelectionOverlayScreen> {
  void _selectProfile(BuildContext context, Profile profile) {
    context.read<ProfilesCubit>().setActiveProfile(profile);
    AnalyticsHelper.logEvent(
      eventName: AmplitudeEvent.profilePressed,
      eventProperties: {
        "profile_name": profile.firstName,
      },
    );
    context.pop();
  }

  @override
  initState() {
    super.initState();
    _fetchProfiles();
  }

  Future<void> _fetchProfiles() async {
    final authState = context.read<AuthCubit>().state;
    if (authState is LoggedInState) {
      context.read<ProfilesCubit>().fetchProfiles(authState.session.userGUID);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profilesState = context.read<ProfilesCubit>().state;

    final profiles = [...profilesState.profiles]
      ..remove(profilesState.activeProfile);

    return Scaffold(
      backgroundColor: const Color.fromARGB(165, 22, 22, 20),
      body: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
            margin: const EdgeInsets.all(30),
            alignment: Alignment.topRight,
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ProfileWalletButton(
                    pageName: Pages.profileSelectionOverlay.name,
                    onPressed: () => context.pop(),
                  ),
                  ...profiles
                      .map(
                        (profile) => GestureDetector(
                          onTap: () => _selectProfile(context, profile),
                          child: ProfileOverlayButton(profile: profile),
                        ),
                      )
                      .take(ProfileSelectionScreen.maxProfilesToShow - 1)
                      .toList(),
                  LogoutButton(pageName: Pages.profileSelectionOverlay.name),
                ],
              ),
            )),
      ),
    );
  }
}
