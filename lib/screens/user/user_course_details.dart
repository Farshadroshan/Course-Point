import 'dart:developer';
import 'dart:io';

import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
import 'package:coursepoint/helpers/video_controller.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
// import 'package:coursepoint/widget/full_screen_video.dart';
import 'package:coursepoint/widget/user_sub_courses.dart';
import 'package:coursepoint/widget/video_player_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class UsercoursedetailsScreen extends StatefulWidget {
  const UsercoursedetailsScreen({super.key, required this.courseDetails , required this.userData});
  final CoursesModel courseDetails;
  final UserLoginModel userData;

  @override
  State<UsercoursedetailsScreen> createState() => _UsercoursedetailsScreenState();
}

class _UsercoursedetailsScreenState extends State<UsercoursedetailsScreen> {
 late VideoPlayerController _controller;
  bool _isMuted = false;
  bool _isPlaying = false;
  

  @override
  
void initState() {
  super.initState();

  if (widget.courseDetails.indroductionvideo != null &&
      widget.courseDetails.indroductionvideo.isNotEmpty) {
        
    if (kIsWeb) {
      // For Web: Use network-based video
      _controller = VideoPlayerController.network(widget.courseDetails.indroductionvideo)
        ..initialize().then((_) {
          setState(() {});
        });
    } else {
      // For Mobile: Use file-based video
      _controller = VideoPlayerController.file(File(widget.courseDetails.indroductionvideo))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  } else {
    log("Video path is null or empty ");
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
      // backgroundColor: const Color(0xFF191919),
      // appBar: AppBar(
      //   backgroundColor: appBarColor,
      //   title:  Text('Details', style: TextStyle(color: appColorblack, fontWeight: FontWeight.bold),),
      //   centerTitle: true,
      //   // iconTheme: const IconThemeData(color: Colors.grey),
      // ),
      appBar: CustomAppBar(title: 'Details', backgroundColor: appBarColor, titleColor: appColorblack),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            VideoPlayerWidget(controller: _controller, isMuted: _isMuted, isPlaying: _isPlaying, toggleMute: _toggleMute, togglePlayPause: _togglePlayPause, skipForward: _skipForward, skipBackward: _skipBackward, goToFullScreen: _goToFullScreen),
          
            // Course title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.courseDetails.coursetitle,
                    style:  TextStyle(
                      color: appColorblack,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.courseDetails.Description,
                    style:  TextStyle(color: appColorblack, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                   Text(
                    'Lessons',
                    style: TextStyle(
                      color:  appColorblack,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            UserSubCourses(widget: widget , mediaQuery: mediaQuery),
          ],
        ),
      ),
    );
  }
} 


