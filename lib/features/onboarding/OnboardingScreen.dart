import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/sign_in_screen/ui/sign_in_screen.dart';
import '../../core/mycore/helper/shared_pref_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "title": "Welcome to My KEMIT",
      "description": "Explore the best of Egypt with our smart tour guide.",
      "icon": Icons.map_rounded,
    },
    {
      "title": "Smart Tour Guide",
      "description": "Get AI-powered recommendations for your trips.",
      "icon": Icons.travel_explore_rounded,
    },
    {
      "title": "Let's Get Started!",
      "description": "Enjoy your journey with My KEMIT App!",
      "icon": Icons.directions_walk_rounded,
    },
  ];

  Future<void> _completeOnboarding() async {
    await SharedPrefHelper.setData('seen_onboarding', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Page View
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                final item = _onboardingData[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item["icon"],
                          size: 120.w, color: Colors.orangeAccent),
                      SizedBox(height: 30.h),
                      Text(
                        item["title"],
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        item["description"],
                        style:
                            TextStyle(fontSize: 16.sp, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          /// Pagination Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingData.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                width: _currentIndex == index ? 20.w : 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? Colors.orangeAccent
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(5.w),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          /// Buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentIndex < _onboardingData.length - 1)
                  TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(
                      "Skip",
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  )
                else
                  const SizedBox(), // Hide Skip on last page

                ElevatedButton(
                  onPressed: () {
                    if (_currentIndex == _onboardingData.length - 1) {
                      _completeOnboarding();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                    backgroundColor: Colors.orangeAccent,
                  ),
                  child: Text(
                    _currentIndex == _onboardingData.length - 1
                        ? "Get Started"
                        : "Next",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
