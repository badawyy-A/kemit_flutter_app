import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/home/image_classification/ui/widgets/choose_image.dart';
import 'package:morshd/features/home/ui/home.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Optional: Ensure ScreenUtil is initialized somewhere before using .h and .w
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Image Recognition"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Use pop instead of push to go back safely
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                // If you want to show image + data later, add here
                // ShowImageAndData(),
                // Divider(),

                ChooseImageDoctor(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
