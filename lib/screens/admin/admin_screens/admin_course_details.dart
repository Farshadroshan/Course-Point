import 'dart:io';
import 'package:coursepoint/widget/admin_sub_course.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:coursepoint/widget/video_player_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Functions/delete_function.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
// import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
// import 'package:coursepoint/Screens/admin/admin_screens/admin_course_playlist.dart';
import 'package:coursepoint/Screens/admin/admin_screens/admin_home.dart';
import 'package:coursepoint/Screens/admin/update/update%20_course_details.dart';
import 'package:coursepoint/helpers/video_controller.dart';
import 'package:coursepoint/screens/admin/add_courses/add_sub_course.dart';
import 'package:coursepoint/widget/add_delete_update_button.dart';
import 'package:coursepoint/widget/apppcolor.dart';
// import 'package:coursepoint/widget/full_screen_video.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AdmincoursedetailsScreen extends StatefulWidget {
  final CoursesModel courseDetails;

  const AdmincoursedetailsScreen({super.key, required this.courseDetails});

  @override
  _AdmincoursedetailsScreenState createState() =>
      _AdmincoursedetailsScreenState();
}

class _AdmincoursedetailsScreenState extends State<AdmincoursedetailsScreen> {
  late VideoPlayerController _controller;
  bool _isMuted = false;
  bool _isPlaying = false;
  // Define the skip duration in seconds
  final int _skipDuration = 10;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller
    // _controller = VideoPlayerController.file(File(widget.courseDetails.indroductionvideo,))
    //   ..initialize().then((_) {
    //     setState(() {}); // Rebuild to show the initialized video
    //   });

    _initializedVideo();
  }

  void _initializedVideo(){
    if(kIsWeb){
      _controller = VideoPlayerController.network(widget.courseDetails.indroductionvideo)
      ..initialize().then((_){
        setState(() {
          
        });
      });
    } else {
      _controller = VideoPlayerController.file(File(widget.courseDetails.indroductionvideo))
      ..initialize().then((_){
        setState(() {
          
        });
      });
    }
  }


  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0 : 1);
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  void _skipForward() {
  VideoControlsHelper.skipForward(_controller);
}

void _skipBackward() {
  VideoControlsHelper.skipBackward(_controller);
}

void _goToFullScreen() {
  VideoControlsHelper.goToFullScreen(context, _controller);
}
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context); 

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: appBarColor,
      //   title: Text(
      //     'Details',
      //     style: TextStyle(color: appColorblack, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
            appBar: CustomAppBar(title: 'Details', backgroundColor: appBarColor, titleColor: appColorblack),

      body: Column(
        children: [
          // Main content area (scrollable)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  // Video player
                  VideoPlayerWidget(controller: _controller, isMuted: _isMuted, isPlaying: _isPlaying, toggleMute: _toggleMute, togglePlayPause: _togglePlayPause, skipForward: _skipForward, skipBackward: _skipBackward, goToFullScreen: _goToFullScreen),
                  
                  const SizedBox(height: 10),
                  
                  // Course title and details
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.courseDetails.coursetitle,
                          style: TextStyle(
                            color: appColorblack,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.courseDetails.Description,
                          style: TextStyle(color: appColorblack, fontSize: 15),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Lessons',
                          style: TextStyle(
                            color: appColorblack,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Lessons List
                  AdminSubCourse(widget: widget, mediaQuery: mediaQuery),
                  // Add some bottom padding to ensure content isn't hidden behind buttons
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          
          // Fixed bottom button bar
          Container(
            padding: const EdgeInsets.only(right: 25, top: 20 ),
            decoration: BoxDecoration(
              // color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildActionButton(context, 'Update', () {
                  showDialog(
                    context: context, 
                    builder: (context) => UpdateCourseDetails(coursedetails: widget.courseDetails),
                  );
                }),
               
                buildActionButton(context, '+ Sub Course', () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => AddSubCourseScreen(course: widget.courseDetails))
                  );
                }),
                buildActionButton(context, 'Delete', () {
                  showDialog(
                    context: context, 
                    builder: (ctx) {
                      return AlertDialog(
                        content: const Text('Are you sure to remove this course'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Close')
                          ),
                          TextButton(
                            onPressed: () {
                              deleteCourse(widget.courseDetails.id!);
                              Navigator.pushAndRemoveUntil(
                                context, 
                                MaterialPageRoute(builder: (ctx) => AdminhomeScreen()), 
                                (route) => false
                              );
                            }, 
                            child: const Text('Delete')
                          )
                        ],
                      );
                    }
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
}

