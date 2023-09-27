import 'package:givt_app_kids_web/core/app/app_config.dart';
import 'package:givt_app_kids_web/core/app/bootstrap.dart';
import 'package:givt_app_kids_web/core/app/givt_app.dart';

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
