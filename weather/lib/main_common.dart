import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'backend/backend.dart';
import 'backend/provider.dart';

void mainCommon() {
  FlutterError.onError = (error) {
    log(error.exceptionAsString(), stackTrace: error.stack);
  };

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      WidgetsBinding.instance!.renderView.automaticSystemUiAdjustment = false;

      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));

      final backend = await AppBackend.init();
      //timeago.setLocaleMessages('pl', timeago.PlMessages());

      runApp(
        BackendProvider(
          backend: backend!,
          child: App(backend: backend),
        ),
      );
    },
    (error, stack) {
      log(error.toString(), stackTrace: stack);
    },
  );
}
