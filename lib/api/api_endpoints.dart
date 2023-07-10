import 'package:mailapp01/utils/shared_preferences_utils.dart';

class ApiEndpoints {
  static const String baseUrl = 'https://api.mailbx.app/api';

  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/logout';
  static String profileUpdate = '/users/$userId/update';

  static const String complexRequest = '/complexes/request';
  static const String joinComplex = '/complexes/add';
  static const String removeComplex = '/complexes/remove';

  static String updateSetting = '/notifications/type/$userId/update';

  static int userId = SharedPreferencesUtils.getIntValuesSF("userId");
}
