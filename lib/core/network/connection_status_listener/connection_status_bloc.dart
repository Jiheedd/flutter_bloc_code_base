import 'package:bloc/bloc.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';

import '../connectivity_services.dart';
import '../network_info.dart';

part 'connection_status_event.dart';
part 'connection_status_state.dart';


class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService _connectivityService;

  ConnectivityBloc(this._connectivityService) : super(ConnectivityInitial()) {
    on<ConnectivityChanged>((event, emit) {
      if (event.isConnected) {
        emit(ConnectivityOnline());
      } else {
        emit(ConnectivityOffline());
      }
    });

    _connectivityService.connectionChange.listen((isConnected) {
      add(ConnectivityChanged(isConnected));
    });
  }
}
// class ConnectionStatusBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
//   final NetworkInfo networkInfo;
//   late StreamSubscription<InternetConnectionStatus> _connectionStatusSubscription;
//
//   ConnectionStatusBloc({required this.networkInfo}) : super(ConnectionInitial()) {
//     on<CheckConnectionStatus>((event, emit) async {
//       final status = await networkInfo.isConnected;
//       print("check connection event = ${event.runtimeType}");
//       print("status = $status");
//       emit(ConnectionStatusChanged(
//         status ? InternetConnectionStatus.connected : InternetConnectionStatus.disconnected,
//       ));
//     });
//
//
//
//     _connectionStatusSubscription = networkInfo.onStatusChange.listen((status) {
//       add(CheckConnectionStatus());
//     });
//   }
//
//   @override
//   Future<void> close() {
//     _connectionStatusSubscription.cancel();
//     print("Bloc connection checker closed");
//     return super.close();
//   }
// }