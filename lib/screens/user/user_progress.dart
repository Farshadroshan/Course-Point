
import 'dart:io';

import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/database/model/progress_model.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserprogressScreen extends StatefulWidget {
  const UserprogressScreen({super.key,required this.currentUserId});

final String currentUserId;
  @override
  State<UserprogressScreen> createState() => _UserprogressScreenState();
}

ValueNotifier<List<CoursesModel>> userProgressNotifier = ValueNotifier([]);


class _UserprogressScreenState extends State<UserprogressScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var courseBox = Hive.box<CoursesModel>('course_db');
    userProgressNotifier.value = courseBox.values.toList();
  }

  @override

  Widget build(BuildContext context) {
    var box = Hive.box<ProgressModel>('progressBox');
     

    return Scaffold(
      // appBar:  AppBar(
      //   backgroundColor:  appBarColor,
       
      //   title: Text("Course Progress", style: TextStyle(color: appColorblack, fontWeight: FontWeight.w600)),
      //   centerTitle: true,
      // ),
      appBar: CustomAppBar(title: 'Course Progress', backgroundColor: appBarColor, titleColor: appColorblack),
      body: 
      
      ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<ProgressModel> box, _) {
          // Filter progress for the current user only
          List<ProgressModel> userProgress = box.values
              .where((progress) => progress.userId == widget.currentUserId)
              .toList();

          if (userProgress.isEmpty) {
            return Center(child: Text('No progress available. '));
          }

          return ListView.builder(
            
            itemCount: userProgress.length,
            
            itemBuilder: (context, index) {
              final progress = userProgress[index];

              final course = userProgressNotifier.value.firstWhere(
                (course) => course.id == progress.courseId,
                orElse: () => CoursesModel(image: '', coursetitle: '', indroductionvideo: '', Description: ''),
              );
             
              // double percentage = (progress.totalSubCourses > 0 )
              // ? (progress.completedSubCourses.length / progress.totalSubCourses) * 100
              // : 0;

              return 
              Card(
  elevation: 10, 
  color: Colors.blueGrey.shade100,
  margin: EdgeInsets.all(10),
  child: Padding(
    padding: EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 130,
          height: 80,
          decoration: BoxDecoration(
            color: appcolorgrey,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: FileImage(File(course.image)),fit: BoxFit.cover)
          ),
        ),
        SizedBox(width: 10), // Space between image and text
        Expanded( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.coursetitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              Text(
                'Completed Sub-Courses: ${progress.completedSubCourses.length}/${progress.totalSubCourses}',
                style: TextStyle(fontSize: 14),
              ),
              // SizedBox(height: 5),
              Row(
                children: [
                  Expanded( // Fix progress bar width issue
                    child: LinearProgressIndicator(
                      value: progress.totalSubCourses > 0 
                          ? progress.completedSubCourses.length / progress.totalSubCourses
                          : 0, // Avoid division by zero
                      minHeight: 6,
                      backgroundColor: white,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('${progress.completedSubCourses.length}/${progress.totalSubCourses}')
                ],
              ),
              Text('${((progress.completedSubCourses.length / progress.totalSubCourses) * 100).toStringAsFixed(1)}% Completed'),
            ],
          ),
        ),
      ],
    ),
  ),
                
              );
            },
          );
        },
      ),
    );
  }

  // top to this is correct 
 
//////////////////////////////////////////////////////////////////

// checking for the name and image 



}


