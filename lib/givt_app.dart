import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/screens/web_placeholder.dart';
import 'app_config.dart';

class GivtApp extends StatelessWidget {
  final AppConfig config;
  const GivtApp(this.config, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Givt Kids',
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 62, 73, 112),
          fontFamily: "Raleway"),
      home: WebPlaceholder(),
    );
  }
}
