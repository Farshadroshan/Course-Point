// import 'dart:developer';

import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
import 'package:coursepoint/database/functions/progress_functions.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
import 'package:coursepoint/screens/user/user_course_notes.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class UsercourseplaylistScreen extends StatefulWidget {
  const UsercourseplaylistScreen({super.key , required this.subcourse, required this.courseId, required this.userData,required this.totalSubCourses});
  final SubcourseModel subcourse;
  final UserLoginModel userData;
  final String courseId;
  final int totalSubCourses;

  @override
  State<UsercourseplaylistScreen> createState() => _UsercourseplaylistScreenState();
}

class _UsercourseplaylistScreenState extends State<UsercourseplaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF191919),

      // appBar: AppBar(
      //   // iconTheme: const IconThemeData(color: Colors.grey),
      //   backgroundColor: appBarColor,
      //   title: Text('Playlist' ,style: TextStyle(color: appColorblack, fontWeight: FontWeight.bold),),
      //   // centerTitle: true,
      //   centerTitle: true,
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       // child: ElevatedButton(
      //       //   style: ElevatedButton.styleFrom(
      //       //     // minimumSize: Size(30, 30),
      //       //     // maximumSize: Size(1, 3)
      //       //   ),
      //       //   onPressed: () {
      //       //    _showCompletionDialog(context);
      //       //   },
      //       //   child: Text("Complete"),
              
      //       // ),
      //       child: TextButton(onPressed: ()=> _showCompletionDialog(context), child: Text('Complete'))
      //     ),
      //   ],
        
      // ),
      appBar: CustomAppBar(title: 'Playlists', backgroundColor: appBarColor, titleColor: appColorblack,showCompleteButton: true,onCompletePressed: () => _showCompletionDialog(context),),
      body: Padding(padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const SizedBox(height: 10,),
          
          ValueListenableBuilder(
            valueListenable: playListNotifier,
            builder: (BuildContext ctx, List<PlaylistModel>playListCourseList, Widget? child){
              final filterdList = playListCourseList.where((play){
                if(play.id != null){
                  
                  return play.subcourseId == widget.subcourse.id;
                }
                return false;
              }).toList();
              return Expanded(
              child: ListView.builder(
              itemCount: filterdList.length,
              itemBuilder: (context, index) {
                final playlistData = filterdList[index];
                return Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          
                         Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> UsercoursenotesScreen(playlistDetails: playlistData, userData: widget.userData, courseId: widget.courseId)));
                         },
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            height: 70,
                            decoration:  BoxDecoration(color: Colors.blueGrey.shade100,borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow( color: Colors.black.withOpacity(0.2), spreadRadius: 2, blurRadius: 5,offset: Offset(3, 3))] ),
                            child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Icon(Icons.playlist_play,),
                              ),
                              const SizedBox(width: 80,),
                              Text(playlistData.plalistTitle,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                            ],
                          ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,)
                    ],
                  )
                );
              },),
            );
            }
             
          )
        ],
      ),
      
      ),
    );
  }



  void _showCompletionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirm Completion"),
        content: Text("Are you sure you want to mark this sub-course as completed?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              onComplete(widget.userData.id!, widget.courseId, widget.subcourse.id!, widget.totalSubCourses);
            },
            child: Text("Conform"),
          ),
        ],
      );
    },
  );
}
}





