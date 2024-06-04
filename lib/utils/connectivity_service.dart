import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../app/default_screen.dart';

class ConnectivityService {
  static connectivity() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        Get.to(() => const DefaultScreen());
      }
    });
  }
}
