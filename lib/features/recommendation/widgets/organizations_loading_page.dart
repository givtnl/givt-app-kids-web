import 'package:flutter/material.dart';

class OrganizationsLoadingPage extends StatelessWidget {
  const OrganizationsLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: replace with lottie 3 dots animation
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
