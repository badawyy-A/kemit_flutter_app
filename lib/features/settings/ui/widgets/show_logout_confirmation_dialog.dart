import 'package:flutter/material.dart';

Future<bool?> showLogoutConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: Colors.red, size: 28),
              const SizedBox(width: 8),
              Text(
                "Log Out",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffD9163A),
                ),
              ),
            ],
          ),
          content: const Text(
            "Are you sure you want to log out?",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
  );
}