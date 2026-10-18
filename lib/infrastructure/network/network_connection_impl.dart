import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mustore/core/network/connectivity/network_connection.dart';

class NetworkConnectionImpl implements NetworkConnection {
  NetworkConnectionImpl([Connectivity? connectivity])
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }
}