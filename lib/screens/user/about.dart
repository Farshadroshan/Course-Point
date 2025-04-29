
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  
    Scaffold(
      
      appBar: CustomAppBar(title: 'About', backgroundColor: appBarColor, titleColor: appColorblack),
      body: const SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(
                    height: 30,
                  ),
                    Text(
                    "About Course Point",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Welcome to Course Point, your ultimate platform for learning programming at your own pace. We provide a comprehensive collection of courses designed to help you build and sharpen your coding skills. Whether you're a beginner or an advanced coder, Course Point offers free access to a variety of topics and resources to suit your learning needs.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Our structure is simple:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• Courses: Each course comes with an introductory video, a detailed description, and sub-courses to dive deeper into specific topics.",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "• Sub-Courses: Explore focused sub-courses, each offering curated playlists to guide you through step-by-step tutorials.",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "• Playlists: Learn from high-quality video tutorials. Each playlist is accompanied by questions and answers to reinforce your learning.",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "• Notes: Take advantage of additional resources and Q&A to help clarify concepts and enhance understanding.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "AI Assistant:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Course Point features an AI Assistant to support your learning journey. Our AI Assistant helps answer programming-related queries, provides explanations, and offers guidance on various coding concepts. This tool ensures you have real-time assistance whenever you need it.",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "• Get instant answers to coding questions.",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "• Receive step-by-step explanations on complex topics.",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "• Improve your understanding with interactive responses.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "What sets Course Point apart is that all courses are completely free! You can enroll in as many courses as you like and track your progress as you advance through the material.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Start learning today, unlock your potential, and track your journey all for free, only on Course Point!",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

