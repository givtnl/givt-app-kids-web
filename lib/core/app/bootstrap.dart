import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/core/app/givt_app.dart';

import 'package:givt_app_kids_web/core/injection/injection.dart' as get_it;

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  final givtApp = await builder();

  await get_it.init((givtApp as GivtApp).config);
  await get_it.getIt.allReady();

  await runZonedGuarded(
    () async => runApp(givtApp),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
