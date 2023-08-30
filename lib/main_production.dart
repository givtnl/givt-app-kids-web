import 'package:givt_app_kids_web/app_config.dart';
import 'package:givt_app_kids_web/bootstrap.dart';
import 'package:givt_app_kids_web/givt_app.dart';

void main() {
  var configuredApp = AppConfig(
    flavorName: 'production',
    apiBaseUrl: 'backend.givtapp.net',
    amplitudePublicKey: '05353d3a94c0d52d75cc1e7d13faa8e1',
  );

  bootstrap(
    () => GivtApp(configuredApp),
  );
}
