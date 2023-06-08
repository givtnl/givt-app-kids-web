import 'package:givt_app_kids_web/app_config.dart';
import 'package:givt_app_kids_web/bootstrap.dart';
import 'package:givt_app_kids_web/givt_app.dart';

void main() {
  var configuredApp = AppConfig(
    flavorName: 'development',
    apiBaseUrl: 'givt-debug-api.azurewebsites.net',
    amplitudePublicKey: 'e02f6615e27048c072e1058476fce30b',
  );

  bootstrap(
    () => GivtApp(configuredApp),
  );
}
