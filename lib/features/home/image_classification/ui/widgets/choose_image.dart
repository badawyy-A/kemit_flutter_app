import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morshd/features/home/image_classification/controller/image_classifier.dart';
import 'package:morshd/features/home/image_classification/ui/widgets/image_classification_response.dart';

class ChooseImageDoctor extends ConsumerStatefulWidget {
  const ChooseImageDoctor({super.key});

  @override
  ConsumerState<ChooseImageDoctor> createState() => _ChooseImageDoctorState();
}

File? _imageGallery;
File? _imageCamera;

class _ChooseImageDoctorState extends ConsumerState<ChooseImageDoctor> {
  bool _isLoading = false;
  String _selectedLanguage = 'English';
  
  // Language options with display names and codes
  final Map<String, String> _languages = {
    'English': 'en',
    'Spanish': 'es',
    'French': 'fr',
    'Arabic': 'ar',
    'German': 'de',
    'Chinese': 'zh',
    'Japanese': 'ja',
  };

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the default language
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatBotControllerProvider.notifier).setLanguage(_languages[_selectedLanguage]!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(80.h),
        Container(
          width: 200.w,
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.asset(
              'assets/images/imgg.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Gap(40.h),
        
        // Language Dropdown
        Container(
          width: 260.w,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.r),
            border: Border.all(color: Color(0xff464A7A), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedLanguage,
              isExpanded: true,
              icon: Icon(Icons.language, color: Color(0xff464A7A)),
              style: TextStyle(
                color: Color(0xff464A7A),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              items: _languages.keys.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                  // Update the controller with the selected language code
                  ref.read(chatBotControllerProvider.notifier).setLanguage(_languages[newValue]!);
                }
              },
            ),
          ),
        ),
        Gap(40.h),

        // Upload Image Button
        if (_imageGallery == null && _imageCamera == null)
          GestureDetector(
            onTap: _showImageSourceDialog,
            child: Container(
              width: 260.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: Color(0xffDF713D),
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    Gap(10.w),
                    Text(
                      'Upload Image',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Gap(80.h),
        // Selected Image Display
        if (_imageGallery != null || _imageCamera != null) ...[
          Gap(20.h),
          Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: Color(0xff464A7A), width: 2),
            ),
            child: Column(
              children: [
                Text(
                  'Selected Image',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Color(0xff464A7A),
                  ),
                ),
                Gap(10.h),
                Image.file(
                  File(_imageCamera != null
                      ? _imageCamera!.path
                      : _imageGallery!.path),
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                ),
                Gap(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Clear Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _imageGallery = null;
                          _imageCamera = null;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.red[400],
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                            Gap(5.w),
                            Text(
                              'Clear',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(15.w),
                    // Send Button
                    GestureDetector(
                      onTap: () async {
                        if (_isLoading) return;

                        setState(() {
                          _isLoading = true;
                        });

                        try {
                          log('Starting image classification...');
                          final controller =
                              ref.read(chatBotControllerProvider.notifier);
                          await controller.chatBot();
                          log('Image classification completed successfully');

                          if (controller.dataAndImage.isNotEmpty) {
                            final result = controller.dataAndImage.last;
                            log('UI: Result data - name: ${result.name}, description: ${result.description}, videoUrl: ${result.videoUrl}');
                            if (mounted) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ImageClassificationResponse(
                                    videoUrl: result.videoUrl,
                                    name: result.name,
                                    description: result.description,
                                  ),
                                ),
                              );
                            }
                          }
                        } catch (e, stackTrace) {
                          log('Error during image classification: $e');
                          log('Stack trace: $stackTrace');

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: ${e.toString()}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Color(0xff464A7A),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            if (_isLoading) ...[
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                              Gap(5.w),
                            ] else ...[
                              FaIcon(
                                FontAwesomeIcons.solidPaperPlane,
                                color: Colors.white,
                                size: 18,
                              ),
                              Gap(5.w),
                            ],
                            Text(
                              _isLoading ? 'Processing...' : 'Send',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text(
            'Choose Image Source',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: Color(0xff464A7A),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Color(0xff464A7A)),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _addImageFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Color(0xff464A7A)),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _addImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _addImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        ref.watch(chatBotControllerProvider.notifier).image = File(image.path);
        _imageGallery = File(image.path);
      });
    }
  }

  Future<void> _addImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        ref.watch(chatBotControllerProvider.notifier).image = File(image.path);
        _imageCamera = File(image.path);
      });
    }
  }
}
