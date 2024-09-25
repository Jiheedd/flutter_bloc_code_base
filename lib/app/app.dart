import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/strings/messages.dart';
import '../core/util/app_localizations.dart';
import '../core/util/app_theme.dart';
import 'app_router.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'Flutter BLoC Using Clean Architecture',
      theme: appTheme,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocal, supportedLocals) {
        for (var local in supportedLocals) {
          if (deviceLocal != null &&
              deviceLocal.languageCode == local.languageCode) {
            return deviceLocal;
          }
        }
        return supportedLocals.first;
      },
      routerConfig: _appRouter.goRouter,
    );
  }
}