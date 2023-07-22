import 'package:mailapp01/utils/shared_preferences_utils.dart';

class ApiEndpoints {
  int? userId = SharedPreferencesUtils.getIntValuesSF("userId");

  String get baseUrl => 'https://api.mailbx.app/api';

  String get login => '/login';
  String get register => '/register';
  String get logout => '/logout';

  String get complexRequest => '/complexes/request';
  String get joinComplex => '/complexes/add';
  String get removeComplex => '/complexes/remove';

  String get updateSetting => '/notifications/type/$userId/update';
  String get listNotifications => '/notifications/$userId';
  String get profileUpdate => '/users/$userId/update';
  String get listComplex => '/complexes/$userId';

  String get verifyUser => '';
}
