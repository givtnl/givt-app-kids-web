import 'dart:html';

import 'package:flutter/material.dart';

class TrialApproval extends StatelessWidget {
  const TrialApproval({super.key});
  static const String routeName = "/parental-trial";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Hi you are on page trial'),
          Text('Uri base origin: ${Uri.base.origin.toString()}'),
          Text(
              'Uri path: ${Uri.parse("http://localhost:61769/#/?decision='true'?transactionId=64922?kidGUID=16e5ce1b-1ec2-4591-8512-0116b0ef647d").fragment}'),
          Text('Window location: ${window.location.href}')
          //
        ],
      )),
    );
  }
}
