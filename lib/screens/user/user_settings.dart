import 'package:coursepoint/screens/user/about.dart';
import 'package:coursepoint/screens/user/privacy_policy.dart';
import 'package:coursepoint/screens/user/terms_and_conditions.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:coursepoint/widget/menuItems.dart';
import 'package:flutter/material.dart';

class UsersettingsScreen extends StatelessWidget {
  const UsersettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context); 
    return Scaffold(

        appBar: CustomAppBar(title: 'Settings', backgroundColor: appBarColor, titleColor: appColorblack),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(padding: EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(),
                MenuItem(text: 'Privacy Policy', icon: Icons.policy_outlined,onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>PrivacyPolicyPage()));
                },),
                Divider(),
                MenuItem(text: 'Terms and Conditions', icon: Icons.document_scanner_outlined,onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>TermsAndConditionsPage()));
                },),
                Divider(),
                MenuItem(text: 'About', icon: Icons.info_outline,onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AboutPage()));
                },),
                Divider(),
              ],
            ),
            ),
          ),
        )
    );
  }
}