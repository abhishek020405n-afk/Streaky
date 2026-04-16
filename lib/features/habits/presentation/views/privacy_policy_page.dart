import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Privacy-first by design', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('HabitFlow keeps all habit and task data securely on your device. We do not collect personal information, we do not require login or OTP verification, and we do not sync your habits to the cloud without your consent.'),
                SizedBox(height: 16),
                Text('What we do:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• Store all habits, reminders, notes, and streak history locally using Hive.'),
                Text('• Offer offline-first operation so core features work without internet.'),
                Text('• Use local notifications for reminders and daily summaries only.'),
                SizedBox(height: 16),
                Text('What we do not do:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• No login or authentication flow.'),
                Text('• No analytics tracking or third-party data collection.'),
                Text('• No cloud backups unless you explicitly export/import data yourself.'),
                SizedBox(height: 16),
                Text('Your data stays on your device.', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('We respect your privacy and build HabitFlow to be a simple, secure place to manage habits and tasks on your own terms.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
