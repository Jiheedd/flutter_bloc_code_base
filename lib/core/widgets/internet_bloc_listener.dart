import 'package:base_code_bloc_flutter/core/util/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../network/connection_status_listener/connection_status_bloc.dart';
import '../strings/messages.dart';
import 'snackbar_message.dart';

class InternetBlocListener extends StatelessWidget {
  final Widget child;
  final Function(BuildContext)? eventOnline;

  const InternetBlocListener({required this.child, super.key, this.eventOnline});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        // print("state is $state");

        if (state is ConnectivityOnline) {
          SnackBarMessage().showSuccessSnackBar(
            message: "internet_connected_success".tr(context),
            context: context,
          );
          if (eventOnline != null) {
            eventOnline!(context);
          }
        }else if (state is ConnectivityOffline) {
          SnackBarMessage().showErrorSnackBar(
            message: "internet_not_connected".tr(context),
            context: context,
          );
        }
      },
      child: child,
    );
  }
}