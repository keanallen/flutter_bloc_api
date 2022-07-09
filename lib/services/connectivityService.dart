import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final _connectivity = Connectivity();

  late StreamController<ConnectivityResult> connectivityStream;

  ConnectivityService() {
    connectivityStream = StreamController();
    _connectivity.onConnectivityChanged.listen((event) {
      connectivityStream.add(event);
    });
  }
}
