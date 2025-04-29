import 'package:coursepoint/screens/user/privacy_policy.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
 Widget build(BuildContext context) {
    return  
    Scaffold(
      
      appBar: CustomAppBar(title: 'Terms and Conditions', backgroundColor: appBarColor, titleColor: appColorblack),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                      Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // CustomBackButton(
                    //     iconColor: themeTextColor,
                    //     buttonColor: buttonGrey,
                    //     onPressed: () {
                    //       Navigator.of(context).pop();
                    //     }),
                   
                    // const Text(
                    //   'Terms and Conditions', 
                    //   style: tutorialPageTitletextStyle,
                    // ),
                     const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
               
                const SizedBox(height: 10),
                const Text(
                  "1. Introduction",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Welcome to Course Point, an e-learning platform designed to help you learn programming at no cost. By using this app, you agree to abide by the following Terms and Conditions. Please read them carefully.",
                ),
                const SizedBox(height: 16),
                const Text(
                  "2. User Responsibilities",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "As a user of Course Point, you agree to use the platform for lawful purposes only. You may not distribute, copy, or sell any content provided in the app without explicit permission.",
                ),
                const SizedBox(height: 16),
                const Text(
                  "3. Content Ownership",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "All content available on Course Point, including videos, text, and graphics, is owned by Course Point and its partners. Unauthorized use of the content is strictly prohibited.",
                ),
                const SizedBox(height: 16),
                const Text(
                  "4. Account and Security",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "When creating an account, you are responsible for maintaining the security of your credentials. Course Point is not liable for any unauthorized access to your account due to your failure to secure your login details.",
                ),
                const SizedBox(height: 16),
                const Text(
                  "5. Limitation of Liability",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Course Point will not be responsible for any indirect or consequential loss or damage that may arise from using the app, including loss of data or profits.",
                ),
                const SizedBox(height: 16),
                const Text(
                  "6. Privacy Policy",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const PrivacyPolicyPage()));
                  },
                  child: const Text(
                    "Please refer to our Privacy Policy to understand how we handle your personal information.",
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "7. Modification of Terms",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Course Point reserves the right to update these Terms and Conditions at any time. We will notify users of any significant changes.",
                ),
                const SizedBox(height: 16),
                const Text(
                  "8. Termination",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Course Point reserves the right to terminate or restrict your access to the app at any time if we determine that you have violated these Terms and Conditions.",
                ),
                const SizedBox(height: 16),
               
              ],
            ),
          ),
        ),
    );
  }
}