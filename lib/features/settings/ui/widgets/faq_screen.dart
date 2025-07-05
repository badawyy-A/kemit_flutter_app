import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  final List<Map<String, String>> faqData = const [
    {
      'question': '1. What does this app do?',
      'answer':
          'This app helps you discover nearby tourist attractions like beaches, museums, hospitals, and more. You can view places on the map or as photos.'
    },
    {
      'question': '2. How can I see places near me?',
      'answer':
          'Once you allow location access, the app will automatically show nearby places based on your current location.'
    },
    {
      'question': '3. Can I view places on the map?',
      'answer':
          'Yes, each place is displayed on a Google Map with markers, so you can easily explore and navigate to your destination.'
    },
    {
      'question': '4. Is there a chatbot for help?',
      'answer':
          'Yes, our smart chatbot is available 24/7 to answer your questions and help you find places or features in the app.'
    },
    {
      'question': '5. What is the image recognition feature?',
      'answer':
          'You can upload or take a picture of a tourist place, and the app will try to recognize and give you information about it.'
    },
    {
      'question': '6. Can I search for hospitals or emergency places?',
      'answer':
          'Absolutely! You can view nearby hospitals and emergency facilities directly from the app’s map or list view.'
    },
    {
      'question': '7. Are the place details available?',
      'answer':
          'Yes, each place comes with a photo, description, and location so you know what to expect before visiting.'
    },
    {
      'question': '8. Do I need an internet connection to use the app?',
      'answer':
          'You need internet to load nearby places, maps, and use the chatbot or image recognition features.'
    },
    {
      'question': '9. Can I save favorite places?',
      'answer':
          'Yes, you can bookmark your favorite places to access them easily later.'
    },
    {
      'question': '10. Is the app free to use?',
      'answer':
          'Yes, the app is completely free to use and provides access to all main features without subscription.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'FAQ',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: faqData.length,
              itemBuilder: (context, index) {
                final item = faqData[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        tilePadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        collapsedBackgroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        iconColor: Colors.black,
                        collapsedIconColor: Colors.black,
                        title: Text(
                          item['question']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, bottom: 12),
                            child: Text(
                              item['answer']!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
