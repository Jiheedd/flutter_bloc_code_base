import 'package:flutter/widgets.dart';

// Wrap your GoRouter configuration to disable Hero transitions
class NoHeroRouterObserver extends NavigatorObserver {
  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Do nothing
  }

  @override
  void didStopUserGesture() {
    // Do nothing
  }
}