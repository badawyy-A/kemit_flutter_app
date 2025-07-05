import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/core/widgets/app_scaffold.dart';
import 'package:morshd/features/home/ui/home.dart';
import 'package:morshd/features/onboarding/OnboardingScreen.dart';
import 'package:morshd/features/sign_in_screen/ui/sign_in_screen.dart';
import '../../core/mycore/helper/constants.dart';
import '../../core/mycore/helper/shared_pref_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double height = 490.h;
  String? userId;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        height = 950.h;
      });
    });

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    try {
      final hasSeenOnboarding = await SharedPrefHelper.getBool(
            SharedPrefKeys.onboardingCompleted,
          ) ??
          false;

      final token = await SharedPrefHelper.getSecuredString(
            SharedPrefKeys.userToken,
          ) ??
          '';

      if (!mounted) return;

      if (token.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else if (hasSeenOnboarding) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    } catch (e) {
      debugPrint('Error in navigation: $e');
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: const Color.fromARGB(255, 250, 250, 250),
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: double.infinity,
            height: height,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          ),
          Positioned(
            top: 210.h,
            child: Image.asset(
              'assets/images/logo.png',
              height: 500.h,
              width: 600.w,
            ),
          ),
        ],
      ),
    );
  }
}
