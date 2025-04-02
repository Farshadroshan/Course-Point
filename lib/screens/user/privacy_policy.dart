import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  
    Scaffold(
      // appBar: AppBar(
      //       title: Text('Privacy Policy',style: TextStyle(fontWeight: FontWeight.bold),),
      //       centerTitle: true,
      //       backgroundColor: appBarColor,
      //   ),
      appBar: CustomAppBar(title: 'Privacy Policy', backgroundColor: appBarColor, titleColor: appColorblack),
        body:const SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: 10),
               Text(
                'Last Updated Date: March 17, 2024\n'
                'Thank you for using Course Point. Your privacy is important to us, and we are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data.\n',
                style: TextStyle(fontSize: 16, ),
              ),
               Text(
                '1. Information We Collect\n',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
               Text(
                'We collect the following types of information when you use our app:\n'
                '- Personal Information: Name, email address, and password provided during sign-up.\n'
                '- Usage Data: Information about your interactions with the app, such as course progress, enrolled courses, and chats with the AI Assistant.\n',
                
                style: TextStyle(fontSize: 16, ),
              ),
               Text(
                '2. How We Use Your Information\n',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
               Text(
                'We use the collected information to:\n'
                '- Provide and enhance the learning experience\n'
                '- Track course progress and manage enrolled courses\n'
                '- Improve the AI Assistant chat experience\n'
                '- Secure user accounts and ensure a safe learning environment'
                '- Communicate with you regarding updates or support\n',
                style: TextStyle(fontSize: 16, ),
              ),
               Text(
                '3. Data Sharing and Security\n',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
               Text(
                'We store your data securely in local databases like Hive and take reasonable precautions to protect it. However, no method of data transmission or storage is 100% secure, and we cannot guarantee absolute protection.\n',
                style: TextStyle(fontSize: 16, ),
              ),
               Text(
                '4. Cookies and Tracking Technologies\n',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
               Text(
                'Course Point may use cookies or similar technologies to enhance user experience. You can choose to disable cookies in your device settings.\n',
               style: TextStyle(fontSize: 16, ),
              ),
               Text(
                '5. Third-Party Links\n',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
               Text(
                'Course Point does not integrate third-party services. However, any external links provided within the app are not under our control, and we encourage you to review their privacy policies.\n',
                style: TextStyle(fontSize: 16, ),
              ),
               Text(
                '6. Your Rights and Choices\n',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                '- Access, update, or delete your personal information\n'
                '- Manage your course enrollment and progress\n'
                '- Opt-out of promotional communications\n'
                '- Restrict certain data processing activities\n',
                style: TextStyle(fontSize: 16, ),
              ),
              const Text(
                '7. Changes to This Privacy Policy\n',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'We may update this Privacy Policy from time to time. Any changes will be posted with a revised "Last Updated" date.\n',
                style: TextStyle(fontSize: 16, ),
              ),
              const Text(
                '8. Contact Us\n',
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'If you have any questions or concerns about this Privacy Policy, please contact us at coursepoint7@gmail.com  .\n',
                style: TextStyle(fontSize: 16, ),
              ),
              Text('By using Course Point, you agree to the terms outlined in this Privacy Policy.\n',
              style: TextStyle(fontSize: 16),)
              
            ],
          ),
        ),
    );
  }
}