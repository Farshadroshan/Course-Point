
import 'dart:io';

import 'package:coursepoint/DataBase/Functions/database_functions.dart';

import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
import 'package:coursepoint/Screens/admin/admin_screens/admin_course_details.dart';
import 'package:coursepoint/Screens/admin/admin_screens/admin_course_playlist.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdminSubCourse extends StatefulWidget {
  const AdminSubCourse({
    super.key,
    required this.widget,
    required this.mediaQuery,
  });

  final AdmincoursedetailsScreen widget;
  final MediaQueryData mediaQuery;

  @override
  State<AdminSubCourse> createState() => _AdminSubCourseState();
}

class _AdminSubCourseState extends State<AdminSubCourse> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: subCourseListNotifier,
      builder: (BuildContext ctx, List<SubcourseModel> subcourseList, Widget? child) {
        final filterList = subcourseList.where((sub) {
          if (sub.id != null) {
            return sub.courseId == widget.widget.courseDetails.id;
          }
          return false;
        }).toList();
    
        return subcourseList.isEmpty
        ? Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Text('Sub-Course Not Available',
            style: TextStyle(color: appColorblack),),
          ),
        ):
        
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final subcourseDetails = filterList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AdminCoursePlayListScreen(subcourse: subcourseDetails)
                  ));
                },
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(3, 3)
                      )
                    ]
                  ),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Container(
                        width: widget.mediaQuery.size.width * 0.30,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            // image: FileImage(File(subcourseDetails.subcourseimage)),
                            image: kIsWeb
                              ? NetworkImage(subcourseDetails.subcourseimage) // web 
                              : FileImage(File(subcourseDetails.subcourseimage)) as ImageProvider, //mobile
                            fit: BoxFit.cover
                          ),
                          borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          subcourseDetails.subcoursetitle,
                          style: TextStyle(
                            color: appColorblack,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: filterList.length,
        );
      },
    );
  }
}