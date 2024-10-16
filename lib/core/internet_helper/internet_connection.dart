import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnection {
  const InternetConnection();
  Future<bool> checkConnection() async {
    final connectionResult = await Connectivity().checkConnectivity();
    if (connectionResult[0] == ConnectivityResult.mobile ||
        connectionResult[0] == ConnectivityResult.wifi) {
      return true;
    } else if (connectionResult[0] == ConnectivityResult.none) {
      return false;
    } else {
      return false;
    }
  }
}
