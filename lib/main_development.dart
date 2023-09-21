import 'package:givt_app_kids_web/app_config.dart';
import 'package:givt_app_kids_web/bootstrap.dart';
import 'package:givt_app_kids_web/givt_app.dart';

void main() {
  var configuredApp = AppConfig(
    flavorName: 'development',
    apiBaseUrl: 'dev-backend.givt.app',
    amplitudePublicKey: 'b629e330cd5913bd1defb72d73b1acd0',
  );

  bootstrap(
    () => GivtApp(configuredApp),
  );
}
