import 'dart:developer';
import 'dart:io';

import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Functions/delete_function.dart';
import 'package:coursepoint/DataBase/Model/note_model.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:coursepoint/Screens/admin/add_courses/admin_add_notes.dart';
import 'package:coursepoint/Screens/admin/update/update_playlist_details.dart';
import 'package:coursepoint/helpers/video_controller.dart';
// import 'package:coursepoint/Screens/admin/admin_add_notes.dart';
import 'package:coursepoint/widget/add_delete_update_button.dart';
import 'package:coursepoint/widget/admin_notes.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:coursepoint/widget/full_screen_video.dart';
import 'package:coursepoint/widget/video_player_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AdminNotesScreen extends StatefulWidget {
   AdminNotesScreen({super.key,required this.playlistDetails});

  final PlaylistModel playlistDetails;

  @override
  State<AdminNotesScreen> createState() => _AdminNotesScreenState();
}

class _AdminNotesScreenState extends State<AdminNotesScreen> {
  late VideoPlayerController _controller;
 bool _isMuted = false;
  bool _isPlaying = false;
  // Define the skip duration in seconds
  final int _skipDuration = 10;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.file(File(widget.playlistDetails.playlistVideo))
    //   ..initialize().then((_) {
    //     setState(() {});
    //   });
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
     
      appBar: CustomAppBar(title: 'Notes', backgroundColor: appBarColor, titleColor: appColorblack),
      body: Column(
          children: [
            // course indroduction video
            VideoPlayerWidget(controller: _controller, isMuted: _isMuted, isPlaying: _isPlaying, toggleMute: _toggleMute, togglePlayPause: _togglePlayPause, skipForward: _skipForward, skipBackward: _skipBackward, goToFullScreen: _goToFullScreen),
          
          
            const SizedBox(
              height: 5,
            ),
            //course title
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                // decoration: BoxDecoration(color: Colors.teal.shade100),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     widget.playlistDetails.plalistTitle, // Use the correct property
                      style: TextStyle(
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
            AdminNotes(widget: widget),
          
            Row(
            children: [
              buildActionButton(context, 'Update', () {
                showDialog(context: context, builder: (ctx) => UpdatePlaylistDetails(playlistdetails: widget.playlistDetails,),);
              }),
              buildActionButton(context, '+ Add Notes', () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) =>  AdminaddnotesScreen(playlist: widget.playlistDetails,)));
              }),
              buildActionButton(context, 'Delete', () {
                showDialog(
                  context: context, 
                  builder: (context) {
                  return AlertDialog(
                    title: Text('Delete'),
                    content: Text('Are you sure to remove this playlist'),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child: Text('cancel')),
                      
                      TextButton(onPressed: (){
                        deletePlayList(widget.playlistDetails.id!);
                        log('note page playlist id = ${widget.playlistDetails.id}');
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text('Delete'))
                    ],
                  );
                },);
              }),
            ],
          ),
          ],
        ),
    
    );
  }
}

