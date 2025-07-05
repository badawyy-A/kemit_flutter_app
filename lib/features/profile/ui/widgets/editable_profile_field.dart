import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditableProfileField extends StatefulWidget {
  final String title;
  final String? value;
  final bool? check;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextEditingController? controller;
  final Function()? onCheckPressed;

  const EditableProfileField({
    super.key,
    required this.title,
    this.value,
    this.check,
    this.validator,
    this.maxLines,
    this.controller,
    this.onCheckPressed,
  });

  @override
  State<EditableProfileField> createState() => _EditableProfileFieldState();
}

class _EditableProfileFieldState extends State<EditableProfileField> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: const Color(0xff343A40),
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: widget.controller,
                    maxLines: widget.maxLines,
                    validator: widget.validator,
                    enabled: isEditing,
                    style: TextStyle(
                      color: const Color(0xff343A40),
                      fontSize: 15.sp,
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFBBD0FF)),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFBBD0FF)),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFBBD0FF)),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      hintText: widget.value,
                      hintStyle: TextStyle(
                        color: const Color(0xff343A40),
                        fontSize: 15.sp,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 13.h,
                      ),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              widget.check == true
                  ? const Icon(
                      Icons.edit_note_rounded,
                      color: Color(0xffDF713D),
                      size: 26,
                    )
                  : GestureDetector(
                      onTap: () {
                        if (isEditing) {
                          if (_formKey.currentState!.validate()) {
                            widget.onCheckPressed?.call();
                            setState(() {
                              isEditing = false;
                            });
                          }
                          // else: validation failed, do not exit edit mode
                        } else {
                          setState(() {
                            isEditing = true;
                          });
                        }
                      },
                      child: Icon(
                        isEditing ? Icons.check : Icons.edit_note_rounded,
                        color: const Color(0xffDF713D),
                        size: 26.sp,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
