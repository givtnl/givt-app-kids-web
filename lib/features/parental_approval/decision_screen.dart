import 'package:flutter/material.dart';

class DecisionApproval extends StatelessWidget {
  const DecisionApproval(
      {required this.decision,
      required this.kidGUID,
      required this.transactionId,
      super.key});
  static const String routeName = "/parental-decision";
  final String decision;
  final String kidGUID;
  final String transactionId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Hi you are on page decision'),
          const SizedBox(height: 20),
          Text(
              'decision is $decision, \nkid is $kidGUID, \ntransaction is $transactionId'),
          //
        ],
      )),
    );
  }
}
