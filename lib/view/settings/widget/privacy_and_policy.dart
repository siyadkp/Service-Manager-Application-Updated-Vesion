import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: KColors.clrDarkBlue,
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for Service Pro',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('Last Updated: [Date]'),
            SizedBox(height: 20),
            Text(
              '1. Information We Collect',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1.1 Personal Data:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'When you use Service Pro, we may collect certain personally identifiable information from you ("Personal Data"). This data may include but is not limited to:',
            ),
            Text(
              '- Your name',
            ),
            Text(
              '- Contact information (email address, phone number, etc.)',
            ),
            Text(
              '- Address or location data',
            ),
            Text(
              '- Profile information (if you create an account)',
            ),
            SizedBox(height: 20),
            Text(
              '1.2 Usage Data:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'We automatically collect certain information about how you interact with the Service. This "Usage Data" may include:',
            ),
            Text(
              '- Device information (e.g., IP address, device type, browser version)',
            ),
            Text(
              '- App usage data (e.g., interactions, features used, time spent on the app)',
            ),
            Text(
              '- Diagnostic information (e.g., crash reports)',
            ),
            SizedBox(height: 20),
            // Add other sections of the privacy policy as needed
          ],
        ),
      ),
    );
  }
}
