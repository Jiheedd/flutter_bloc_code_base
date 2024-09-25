// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
// abstract class NetworkInfo {
//   Future<bool> get isConnected;
//   Stream<InternetConnectionStatus> get onStatusChange;
// }
//
// class NetworkInfoImpl implements NetworkInfo {
//   final InternetConnectionChecker internetConnectionChecker;
//
//   NetworkInfoImpl(this.internetConnectionChecker);
//
//   @override
//   Future<bool> get isConnected => internetConnectionChecker.hasConnection;
//
//   @override
//   Stream<InternetConnectionStatus> get onStatusChange => internetConnectionChecker.onStatusChange;
// }