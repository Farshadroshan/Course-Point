import 'dart:io';
import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Model/note_model.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:coursepoint/database/functions/favorites_functions.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
import 'package:coursepoint/helpers/video_controller.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:coursepoint/widget/full_screen_video.dart';
import 'package:coursepoint/widget/user_notes.dart';
import 'package:coursepoint/widget/video_player_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';


class UsercoursenotesScreen extends StatefulWidget {
  const UsercoursenotesScreen({
    super.key,
    required this.playlistDetails,
    required this.userData,
    required this.courseId,
  });
  final UserLoginModel userData;
  final PlaylistModel playlistDetails;
  final String courseId;

  @override
  State<UsercoursenotesScreen> createState() => _UsercoursenotesScreenState();
}

class _UsercoursenotesScreenState extends State<UsercoursenotesScreen> {
  late VideoPlayerController _controller;
  bool _isMuted = false;
  bool _isPlaying = false;
  // Define the skip duration in seconds
  final int _skipDuration = 10;

  @override
  void initState() {
    super.initState();
    
    _initializedVideo();
  }

  void _initializedVideo(){
    if(kIsWeb){
      _controller = VideoPlayerController.network(widget.playlistDetails.playlistVideo)
      ..initialize().then((_){
        setState(() {
          
        });
      });
    } else {
      _controller = VideoPlayerController.file(File(widget.playlistDetails.playlistVideo))
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
      appBar: CustomAppBar(
                title: "Notes",
                backgroundColor: appBarColor,
                titleColor: appColorblack,
                showFavoriteIcon: true,
                isFavorite: () => isFavoritePlaylist(widget.userData.id!, widget.playlistDetails.id!),
                onFavoriteToggle: () async {
                bool isFav = await isFavoritePlaylist(widget.userData.id!, widget.playlistDetails.id!);
                if (isFav) {
                  await removeFavoritePlaylist(widget.userData.id!, widget.playlistDetails.id!);
                } else {
                  await addFavoritePlaylist(widget.userData.id!, widget.playlistDetails.id!);
                }
                setState(() {
                
                });
                },
            ),
        body: Column(
        children: [
          
          VideoPlayerWidget(controller: _controller, isMuted: _isMuted, isPlaying: _isPlaying, toggleMute: _toggleMute, togglePlayPause: _togglePlayPause, skipForward: _skipForward, skipBackward: _skipBackward, goToFullScreen: _goToFullScreen),
          

          const SizedBox(
            height: 5,
          ),
          //course title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:  SizedBox(
              width: double.infinity,
              // decoration: BoxDecoration(color: Colors.teal.shade100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.playlistDetails.plalistTitle,
                    style:  TextStyle(
                        color: appColorblack,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Notes',
                    style: TextStyle(
                        color: appColorblack,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          UserNotes(widget: widget),
        ],
      ),
    );
  }
}



