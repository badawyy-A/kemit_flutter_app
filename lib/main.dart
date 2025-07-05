import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:morshd/core/caching/app_shared_pref.dart';
import 'package:morshd/core/mycore/di/service_locator.dart';
import 'package:morshd/features/home/api/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fvp/fvp.dart' as fvp; // **Add this import**


import 'morshd.dart';

Future<void> main() async {
  await setupGetIt();
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // **Add this FVP initialization line BEFORE runApp()**
    fvp.registerWith(options: {'platforms': ['linux']});

    await AppSharedPref.initSharedPref();

    try {
      Gemini.init(apiKey: GEMINI_API_KEY);
      print('Gemini initialized successfully.');
    } catch (e) {
      print('Failed to initialize Gemini: $e');
    }

    runApp(
      ProviderScope(
        child: MorshdApp(),
      ),
    );
  }, (error, stackTrace) {
    print('Caught an error: $error');
    print('Stack trace: $stackTrace');
  });
}