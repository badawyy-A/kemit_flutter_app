import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            title: const Text('Contact Support',),
            centerTitle: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'If you need any help or have any questions, feel free to contact our support team.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                    const SizedBox(height: 24),
                    buildSupportCard(),
                    const SizedBox(height: 24),
                    buildSocialMediaCard(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSupportCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer Support',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffDF713D),
              )),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.phone, color: Color(0xFF4A90E2)),
              const SizedBox(width: 8),
              Text('Contact Number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  )),
              const SizedBox(width: 8),
              Text('+123-456-7890',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  )),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.email_outlined, color: Color(0xFF4A90E2)),
              const SizedBox(width: 8),
              Text('Email Address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  )),
              const SizedBox(width: 8),
              Flexible(
                  child: Text('support@yourapp.com',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ))),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSocialMediaCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Social Media',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffDF713D),
              )),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.twitter,
                color: Color(0xFF1DA1F2),
              ),
              const SizedBox(width: 8),
              Text('Twitter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  )),
              const SizedBox(width: 8),
              Text('twitter@yourapp.com',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  )),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.facebook, color: Color(0xFF1877F2)),
              const SizedBox(width: 8),
              Text('Facebook',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  )),
              const SizedBox(width: 8),
              Text('facebook@yourapp.com',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  )),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(FontAwesomeIcons.instagram, color: Color(0xFFE1306C)),
              const SizedBox(width: 8),
              Text('Instagram',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  )),
              const SizedBox(width: 8),
              Text('instagram@yourapp.com',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
