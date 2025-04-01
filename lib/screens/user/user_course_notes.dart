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
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 10, right: 10),
            child: Container(
              width: double.infinity,
              height: mediaQuery.size.height * 0.24,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _controller.value.isInitialized
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Stack(
                              children: [
                                VideoPlayer(_controller),
                                // Left side clickable area
                                Positioned.fill(
                                  child: Row(
                                    children: [
                                      // Left half for backward skip
                                      Expanded(
                                        child: GestureDetector(
                                          onDoubleTap: _skipBackward,
                                          child: Container(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      // Right half for forward skip
                                      Expanded(
                                        child: GestureDetector(
                                          onDoubleTap: _skipForward,
                                          child: Container(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            _isMuted ? Icons.volume_off : Icons.volume_up,
                            color: Colors.white,
                          ),
                          onPressed: _toggleMute,
                        ),
                        IconButton(
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: _togglePlayPause,
                        ),
                        Expanded(
                          child: VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                              playedColor: Colors.teal,
                              bufferedColor: Colors.grey,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.fullscreen, color: Colors.white),
                          onPressed: _goToFullScreen,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),


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

          ValueListenableBuilder(
            valueListenable: noteListNotifier,
            builder: (BuildContext ctx, List<NoteModel>notecourseList, Widget? child){
              final filterdList = notecourseList.where((note){
                if(note.id != null){
                  return note.playlistId == widget.playlistDetails.id;
                }
                return false;
              }).toList();
              return Expanded(
                child: ListView.builder(
                  itemCount: filterdList.length,
                  itemBuilder: (context, index) {
                    final noteDetails = notecourseList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        title: 
                        Text(
                          noteDetails.notequestion,
                          style:  TextStyle(
                            fontSize: 20,
                            color:  appColorblack,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        trailing:  Icon(Icons.arrow_drop_down,color: appColorblack,),
                       
                        tilePadding: const EdgeInsets.all(0),
                        children: [
                          ListBody(
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: noteDetails.noteAnswer,
                                  style:  TextStyle(
                                    fontSize: 18,
                                    color: appColorblack,
                                    fontWeight: FontWeight.w300
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}

