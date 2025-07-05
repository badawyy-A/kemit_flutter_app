import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleButton extends StatefulWidget {
  final ValueChanged<int> onToggle;
  const ToggleButton({super.key, required this.onToggle});

  @override
  State<ToggleButton> createState() => _DoctorsToggleButtonState();
}

class _DoctorsToggleButtonState extends State<ToggleButton> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 328.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: const Color(0xffeeeeee),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            _buildSegment("List View", 0),
            _buildSegment("Map View", 1),
          ],
        ),
      ),
    );
  }

  Widget _buildSegment(String text, int index) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          widget.onToggle(selectedIndex);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xffDF713D) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              color: isSelected ? Colors.white : const Color(0xffDF713D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
