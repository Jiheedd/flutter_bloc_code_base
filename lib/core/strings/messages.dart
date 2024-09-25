

import 'package:flutter/material.dart';

import '../error/failures.dart';
import '../util/app_localizations.dart';

//
// const ADD_SUCCESS_MESSAGE = "Post Added Successfully";
// const DELETE_SUCCESS_MESSAGE = "Post Deleted Successfully";
// const UPDATE_SUCCESS_MESSAGE = "Post Updated Successfully";
// const INTERNET_CONNECTED_SUCCESS_MESSAGE = "You are connected to the internet.";
// const INTERNET_NOT_CONNECTED_MESSAGE = "You are disconnected from the internet.";

class FailureMessages {

  static Map<Type, String> mapLocalizedFailureMessages = {};
  void init(BuildContext context) {
    if (mapLocalizedFailureMessages.isEmpty) {
      print("init FailureMessages");
      mapLocalizedFailureMessages = getLocalizedFailureMessages(context);
    }
  }
  Map<Type, String> getLocalizedFailureMessages(BuildContext context) {
    return {
      ServerFailure: 'server_failure'.tr(context),
      OfflineFailure: 'offline_failure'.tr(context),
      EmptyCacheFailure: 'empty_cache_failure'.tr(context),
      PackageFailure: 'internal_failure'.tr(context),
      UnknownFailure: 'unexpected_error'.tr(context),
    };
  }
}