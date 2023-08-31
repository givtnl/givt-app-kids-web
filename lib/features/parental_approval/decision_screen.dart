import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_app_kids_web/utils/size_utils.dart';

import 'bloc/decision_bloc.dart';

class DecisionApproval extends StatelessWidget {
  const DecisionApproval(
      {required this.decision,
      required this.kidGUID,
      required this.transactionId,
      required this.kidName,
      required this.organizationName,
      super.key});

  static const String routeName = "/parent-decision";
  final bool decision;
  final String kidGUID;
  final String transactionId;
  final String kidName;
  final String organizationName;

  @override
  Widget build(BuildContext context) {
    final double anchorSize = SizeUtil.anchorSize(context);
    return BlocConsumer<DecisionBloc, DecisionState>(
      listener: (context, state) {
        log(state.status.toString());
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: getBackgroundColor(state.status),
          body: Center(
            child: Container(
              width: anchorSize * 0.35,
              height: anchorSize * 0.35,
              decoration: BoxDecoration(
                  color: getCardColor(state.status),
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.all(anchorSize * 0.05),
              child: _buildColumn(state, anchorSize, context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildColumn(
      DecisionState state, double anchorSize, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        getIcon(state.status),
        const Spacer(),
        Text(getText(state.status, state.errorMessage),
            style: TextStyle(
              color: Colors.white,
              fontSize: anchorSize * 0.02,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 20),
        state.status == DecisionStatus.error && state.errorMessage.isEmpty
            ? Text('Please try again later.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: anchorSize * 0.015,
                ))
            : const SizedBox(),
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

  String getText(DecisionStatus status, String errorMessage) {
    switch (status) {
      case DecisionStatus.initial:
        return 'Working on it...';
      case DecisionStatus.loading:
        return 'Working on it...';
      case DecisionStatus.approved:
        return 'Thank you!\n$kidName\'s donation to $organizationName has been approved.';
      case DecisionStatus.error:
        return getErrorText(errorMessage);
      case DecisionStatus.declined:
        return '$kidName\'s donation to $organizationName is successfully declined.';
    }
  }

  String getErrorText(String errorMessage) {
    switch (errorMessage) {
      case 'TRANSACTION_ALREADY_DECLINED':
        return 'This transaction has already been declined.';
      case 'TRANSACTION_ALREADY_APPROVED':
        return 'This transaction has already been approved.';
      default:
        return 'Oops something went wrong.';
    }
  }

  Color getCardColor(DecisionStatus status) {
    switch (status) {
      case DecisionStatus.initial:
        return const Color.fromRGBO(53, 80, 112, 1);
      case DecisionStatus.loading:
        return const Color.fromRGBO(53, 80, 112, 1);
      case DecisionStatus.approved:
        return const Color.fromRGBO(125, 189, 161, 1);
      case DecisionStatus.error:
        return const Color.fromRGBO(211, 114, 109, 1);
      case DecisionStatus.declined:
        return const Color.fromRGBO(53, 80, 112, 1);
    }
  }

  Color getBackgroundColor(DecisionStatus status) {
    switch (status) {
      case DecisionStatus.initial:
        return const Color.fromRGBO(54, 109, 174, 0.20);
      case DecisionStatus.loading:
        return const Color.fromRGBO(54, 109, 174, 0.20);
      case DecisionStatus.approved:
        return const Color.fromRGBO(125, 189, 161, 0.20);
      case DecisionStatus.error:
        return const Color.fromRGBO(211, 114, 109, 0.20);
      case DecisionStatus.declined:
        return const Color.fromRGBO(54, 109, 174, 0.20);
    }
  }
}
