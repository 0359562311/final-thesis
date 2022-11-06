import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  bool isConnecting = false;
  Future<void> init() async {
    this.isConnecting =
        (await Connectivity().checkConnectivity()) != ConnectivityResult.none;
  }
}
