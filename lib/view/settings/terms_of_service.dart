import 'package:flutter/material.dart';
import 'package:service_manager/core/colors.dart';

class TermsOfServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColors.clrDarkBlue,
        title: const Text('Terms of Service'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms of Service for Service Pro',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('Last Updated: [Date]'),
            SizedBox(height: 20),
            Text(
              '1. Acceptance of Terms',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'By using Service Pro, you agree to be bound by these Terms of Service. If you do not agree with any part of these terms, you may not use the Service.',
            ),
            SizedBox(height: 20),
            Text(
              '2. Use of Service Pro',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '2.1 Eligibility:',
            ),
            Text(
              'You must be at least 18 years old to use this Service. By using the Service, you represent and warrant that you have the legal capacity to enter into this agreement.',
            ),
            Text(
              '2.2 User Accounts:',
            ),
            Text(
              'To access certain features of Service Pro, you may be required to create a user account. You are responsible for maintaining the confidentiality of your account credentials.',
            ),
            SizedBox(height: 20),
            // Add other sections of the terms of service as needed
          ],
        ),
      ),
    );
  }
}
