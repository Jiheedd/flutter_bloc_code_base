import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;


class ConnectivityService {
  final Connectivity _connectivity;
  final StreamController<bool> _connectionChangeController = StreamController<bool>.broadcast();

  ConnectivityService(this._connectivity) {
    _connectivity.onConnectivityChanged.listen(_checkInternetConnection);
  }

  Stream<bool> get connectionChange => _connectionChangeController.stream;
  Future<bool> get isConnected => _isConnectedToInternet();

  void _checkInternetConnection(List<ConnectivityResult> result) async {
    bool isConnected = await _isConnectedToInternet();
    _connectionChangeController.add(isConnected);
  }

  Future<bool> _isConnectedToInternet() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com')).timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  void dispose() {
    _connectionChangeController.close();
  }
}