// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:givt_app_kids_web/core/app/pages.dart';
// import 'package:givt_app_kids_web/features/auth/cubit/auth_cubit.dart';
// import 'package:givt_app_kids_web/features/profiles/cubit/profiles_cubit.dart';
// import 'package:givt_app_kids_web/features/profiles/widgets/find_charity_button.dart';
// import 'package:givt_app_kids_web/features/profiles/widgets/pending_approval_widget.dart';
// import 'package:givt_app_kids_web/features/profiles/widgets/profile_switch_button.dart';
// import 'package:givt_app_kids_web/features/profiles/widgets/wallet_frame.dart';
// import 'package:givt_app_kids_web/features/profiles/widgets/wallet_widget.dart';
// import 'package:givt_app_kids_web/utils/analytics_helper.dart';
// import 'package:go_router/go_router.dart';

// class WalletScreen extends StatefulWidget {
//   const WalletScreen({super.key});

//   @override
//   State<WalletScreen> createState() => _WalletScreenState();
// }

// class _WalletScreenState extends State<WalletScreen>
//     with WidgetsBindingObserver {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addObserver(this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     log('state = $state');
//     if (AppLifecycleState.resumed == state) {
//       refresh();
//     }
//   }

//   Future<void> refresh() async {
//     final parentGuid =
//         (context.read<AuthCubit>().state as LoggedInState).session.userGUID;
//     await context.read<ProfilesCubit>().fetchProfiles(parentGuid);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return BlocBuilder<ProfilesCubit, ProfilesState>(builder: (context, state) {
//       final isPending = state.activeProfile.wallet.pending > 0.0;
//       final isGiveButtonActive = state.activeProfile.wallet.balance > 0;
//       final isLoading = state is ProfilesLoadingState;

//       var countdownAmount = 0.0;
//       if (state is ProfilesCountdownState) {
//         countdownAmount = state.amount;
//       }

//       return WalletFrame(
//         body: RefreshIndicator(
//           onRefresh: refresh,
//           child: Stack(
//             children: [
//               ListView(),
//               Column(
//                 key: UniqueKey(),
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Heading2(text: state.activeProfile.firstName),
//                   if (isLoading)
//                     const Center(child: CircularProgressIndicator())
//                   else
//                     GestureDetector(
//                       onLongPress: () => context
//                           .pushReplacementNamed(Pages.searchForCoin.name),
//                       child: WalletWidget(
//                         balance: state.activeProfile.wallet.balance,
//                         countdownAmount: countdownAmount,
//                       ),
//                     ),
//                   SizedBox(height: size.height * 0.01),
//                   QrGiveButton(isActive: isGiveButtonActive),
//                   const FindCharityButton(),
//                   if (isPending) SizedBox(height: size.height * 0.03),
//                   if (isPending)
//                     PendingApprovalWidget(
//                       pending: state.activeProfile.wallet.pending,
//                     ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         fab: ProfileSwitchButton(
//             name: state.activeProfile.firstName,
//             onClicked: () {
//               context.pushReplacementNamed(Pages.profileSelection.name);

//               AnalyticsHelper.logEvent(
//                 eventName: AmplitudeEvent.profileSwitchPressed,
//               );
//             }),
//         fabLocation: FloatingActionButtonLocation.startFloat,
//       );
//     });
//   }
// }