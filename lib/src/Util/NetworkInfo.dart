import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasInternetConnection() async {
  try {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();

    switch (connectivity) {
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.ethernet:
        return true;
      case ConnectivityResult.none:
        return false;
      default:
        return false;
    }
  } catch (err) {
    print(err);
    return false;
  }
}