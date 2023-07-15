import 'package:internet_connection_checker/internet_connection_checker.dart';

class Internet {
  Future<bool> checkInternetConn() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
