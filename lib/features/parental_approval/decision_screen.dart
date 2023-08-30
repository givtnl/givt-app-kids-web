import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_app_kids_web/features/parental_approval/cubit/decision_cubit.dart';
import 'package:givt_app_kids_web/utils/size_utils.dart';

class DecisionApproval extends StatelessWidget {
  const DecisionApproval(
      {required this.decision,
      required this.kidGUID,
      required this.transactionId,
      super.key});

  static const String routeName = "/parent-decision";
  final String decision;
  final String kidGUID;
  final String transactionId;
  final String kidName = 'Brad';
  final String organizationName = 'WWF';

  @override
  Widget build(BuildContext context) {
    final double anchorSize = SizeUtil.anchorSize(context);
    return BlocProvider(
      create: (context) => DecisionCubit(),
      child: BlocConsumer<DecisionCubit, DecisionState>(
        listener: (context, state) {
          log(state.status.toString());
          if (state.status == DecisionStatus.initial) {
            log('executing');
            context.read<DecisionCubit>().approve();
          }
          if (state.status == DecisionStatus.approved) {
            log('approved');
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromRGBO(54, 109, 174, 0.20),
            body: Center(
              child: Container(
                width: anchorSize * 0.35,
                height: anchorSize * 0.35,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(53, 80, 112, 1),
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.all(anchorSize * 0.05),
                child: _buildColumn(state, anchorSize, context),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildColumn(
      DecisionState state, double anchorSize, BuildContext context) {
    // if (state.status == DecisionStatus.initial) {
    //   context.read<DecisionCubit>().approve();
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ElevatedButton(
        //     onPressed: () => context.read<DecisionCubit>().approve(),
        //     child: Text('Approve')),
        const Spacer(),
        getIcon(state.status),
        const Spacer(),
        Text(getText(state.status),
            style: TextStyle(
              color: Colors.white,
              fontSize: anchorSize * 0.02,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 20),
        Text(state.status.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: anchorSize * 0.015,
            )),
        const Spacer(),
      ],
    );
  }

  Widget getIcon(DecisionStatus status) {
    switch (status) {
      case DecisionStatus.initial:
        return const CircularProgressIndicator(color: Colors.white);
      case DecisionStatus.loading:
        return const CircularProgressIndicator(color: Colors.white);
      case DecisionStatus.approved:
        return SvgPicture.asset('images/approved.svg');
      case DecisionStatus.error:
        return SvgPicture.asset('images/declined.svg');
      case DecisionStatus.declined:
        return SvgPicture.asset('images/declined.svg');
    }
  }

  String getText(DecisionStatus status) {
    switch (status) {
      case DecisionStatus.initial:
        return 'Working on it...';
      case DecisionStatus.loading:
        return 'Working on it...';
      case DecisionStatus.approved:
        return 'Thank you!\n$kidName\'s donation to $organizationName has been approved.';
      case DecisionStatus.error:
        return 'Oops something went wrong.';
      case DecisionStatus.declined:
        return '$kidName\'s donation to $organizationName is successfully.';
    }
  }
}
