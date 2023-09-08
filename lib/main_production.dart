import 'package:givt_app_kids_web/app_config.dart';
import 'package:givt_app_kids_web/bootstrap.dart';
import 'package:givt_app_kids_web/givt_app.dart';

void main() {
  var configuredApp = AppConfig(
    flavorName: 'production',
    apiBaseUrl: 'backend.givt.app',
    amplitudePublicKey: '5e5b687fee8a7a6a91bfae9c6fdc2eb1',
  );

  bootstrap(
    () => GivtApp(configuredApp),
  );
}
