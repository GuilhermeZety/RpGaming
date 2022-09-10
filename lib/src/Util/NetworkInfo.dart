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

 //  subscription = Connectivity()
  //     .onConnectivityChanged
  //   .listen((ConnectivityResult result) {

  //   switch (result) {
  //     case ConnectivityResult.wifi:
  //       setState(() {
  //         hasInternet = true;
  //       });
  //       break;
  //     case ConnectivityResult.mobile:
  //       setState(() {
  //         hasInternet = true;
  //       });
  //       break;
  //     case ConnectivityResult.ethernet:
  //       setState(() {
  //         hasInternet = true;
  //       });
  //       break;
  //     case ConnectivityResult.none:
  //       setState(() {
  //         hasInternet = false;
  //       });
  //       break;
  //     default:
  //       setState(() {
  //         hasInternet = false;
  //       });
  //       break;
  //   }
  //   // Got a new connectivity status!
  //   print("Check: $hasInternet");
  // });