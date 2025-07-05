import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: CurvedNavigationBar(
        index: currentIndex,
        animationDuration: const Duration(milliseconds: 400),
        backgroundColor: Colors.transparent,
        color: const Color(0xffcea16e),
        onTap: onTap,
        items: [
          const Icon(Icons.camera_alt_rounded, size: 30, color: Colors.white),
          Icon(FontAwesomeIcons.robot, size: 25, color: Colors.white),
          const Icon(Icons.home, size: 30, color: Colors.white),
          const Icon(Icons.map_outlined, size: 30, color: Colors.white),
          const Icon(Icons.settings, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
