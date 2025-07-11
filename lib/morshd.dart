import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/core/mycore/di/service_locator.dart';
import 'package:morshd/features/home/chat_gemini/home_page.dart';
import 'package:morshd/features/splash/splash_screen.dart';

import 'core/mycore/logic/user_cubit/user_cubit.dart';
import 'features/home/image_classification/ui/widgets/screen.dart';

class MorshdApp extends StatelessWidget {
  const MorshdApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Gemini.init(apiKey: "AIzaSyCtfFDf4hRB6y-GwTipR80tCXnBA9HojXs");

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider<UserCubit>(
        create: (_) => getIt<UserCubit>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Roboto',
          ),
          home: const SplashScreen(),
          routes: {
            '/home': (context) => const HomePage(),
            '/splash': (context) => const SplashScreen(),
            '/image_classification': (context) =>
                const ImageClassificationScreen(),
          },
        ),
      ),
    );
  }
}




/*

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/home/chat_gemini/home_page.dart';
import 'package:morshd/features/home/image_classification/ui/widgets/screen.dart';
import 'package:morshd/features/splash/splash_screen.dart';

class MorshdApp extends StatelessWidget {
  const MorshdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
        ),
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const HomePage(),
          '/splash': (context) => const SplashScreen(),
          '/image_classification': (context) => const ImageClassificationScreen(),
        },
      ),
    );
  }
}
*/