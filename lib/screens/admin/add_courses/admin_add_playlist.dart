
import 'dart:convert';
import 'dart:io';

import 'package:coursepoint/DataBase/Functions/course_add_functions.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class AdminAddPlaylistScreen extends StatefulWidget {
  final SubcourseModel subcourse;
  const AdminAddPlaylistScreen({super.key, required this.subcourse});

  @override
  _AdminAddPlaylistScreenState createState() => _AdminAddPlaylistScreenState();
}

class _AdminAddPlaylistScreenState extends State<AdminAddPlaylistScreen> {
  final TextEditingController playlistTitle = TextEditingController();
  final ImagePicker videoPicker = ImagePicker();
  VideoPlayerController? videoController;
  bool isVideoLoading = false;
  Uint8List? videoBytes; // Store video bytes for web
  String? videoBase64; // Store video as base64 for web
  XFile? videoFile;
  String? videoPath;
  String? video;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    videoController?.dispose();
    playlistTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text(
          'Add Playlist',
          style: TextStyle(
              color: appColorblack, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Add Playlist Video", style: TextStyle(color: appColorblack, fontSize: 18,fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            // GestureDetector(
            //   onTap: pickgalleryVideo,
            //   child: Container(
            //     width: double.infinity,
            //     height: 150,
            //     decoration: BoxDecoration(
            //       color: Colors.blueGrey.shade100,
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: videoController != null && videoController!.value.isInitialized
            //         ? ClipRRect(
            //             borderRadius: BorderRadius.circular(10),
            //             child: AspectRatio(
            //               aspectRatio: videoController!.value.aspectRatio,
            //               child: VideoPlayer(videoController!),
            //             ),
            //           )
            //         : const Center(
            //             child: Icon(Icons.videocam, size: 50, color: Colors.grey),
            //           ),
            //   ),
            // ),
            GestureDetector(
      onTap: () => pickgalleryVideo(),
      child: Container(
        width: double.infinity,
        height: 200,     
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: isVideoLoading 
            ? const Center(child: CircularProgressIndicator())
            : videoController != null && videoController!.value.isInitialized
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AspectRatio(
                          aspectRatio: videoController!.value.aspectRatio,
                          child: VideoPlayer(videoController!),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 50,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        onPressed: () {
                          setState(() {
                            videoController!.value.isPlaying
                                ? videoController!.pause()
                                : videoController!.play();
                          });
                        },
                      ),
                    ],
                  )
                : const Center(child: Icon(Icons.videocam, size: 50, color: Colors.grey)),
      ),
    ),


            const SizedBox(height: 20),
            Text("Add Playlist Title", style: TextStyle(color: appColorblack, fontSize: 18,fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return 'Enter the title ';
                  }else if (value.trim().length<3){
                    return 'Must be at least 3 characters long ';
                  }
                  return null ;
                },
                controller: playlistTitle,
                cursorColor: Colors.grey,
                
                decoration: InputDecoration(
                  hintText: "Enter playlist title",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: appColorblack),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: submitPlaylist,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> pickgalleryVideo() async {
  //   final pickedvideoFile = await videoPicker.pickVideo(source: ImageSource.gallery);
  //   if (pickedvideoFile != null) {
  //     if (videoController != null) {
  //       await videoController!.dispose();
  //     }
  //     videoController = VideoPlayerController.file(File(pickedvideoFile.path))
  //       ..initialize().then((_) {
  //         setState(() {});
  //         videoController!.play();
  //       });
  //     video = pickedvideoFile.path;
  //   }
  // }

  Future<void> pickgalleryVideo() async {
    final pickedFile = await videoPicker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        isVideoLoading = true;
        videoFile = pickedFile;
      });
      
      try {
        if (kIsWeb) {
          // For web, read as bytes and create a controller from memory
          final bytes = await pickedFile.readAsBytes();
          videoBytes = bytes;
          videoBase64 = base64Encode(bytes);
          
          // Initialize the video controller for web
          videoController?.dispose();
          videoController = VideoPlayerController.networkUrl(
            Uri.dataFromBytes(bytes, mimeType: 'video/mp4'),
          );
          
          await videoController!.initialize();
          await videoController!.setVolume(1.0);
          
        } else {
          // For mobile, use the file path
          videoPath = pickedFile.path;
          
          videoController?.dispose();
          videoController = VideoPlayerController.file(File(pickedFile.path));
          await videoController!.initialize();
          await videoController!.setVolume(1.0);
        }
        
        setState(() {
          isVideoLoading = false;
        });
        
        // Auto-play the video once
        videoController!.play();
        
      } catch (e) {
        print("Error loading video: $e");
        setState(() {
          isVideoLoading = false;
        });
        
        // Show error to user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading video: $e')),
        );
      }
    }
  }

  void submitPlaylist() {
    if (!_formKey.currentState!.validate()  ||(videoPath == null && videoFile == null) ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }
    final videoData = kIsWeb 
      ? "BASE64:$videoBase64" 
      : videoPath!;

    final playListData = PlaylistModel(
      playlistVideo: videoData,
      plalistTitle: playlistTitle.text,
      subcourseId: widget.subcourse.id!,
    );

    addPlayList(playListData);
    Navigator.of(context).pop();
  }

  // void submitCourse(BuildContext context) {
  //   if (!_formKey.currentState!.validate() || (imagePath == null && imageBase64 == null) || (videoPath == null && videoFile == null)) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please fill all fields and add media')),
  //     );
  //     return;
  //   }
  //   // Use a special prefix to identify base64 images for web
  // final imageData = kIsWeb 
  //     ? "BASE64:$imageBase64" 
  //     : imagePath!;
      
  // final videoData = kIsWeb 
  //     ? "BASE64:$videoBase64" 
  //     : videoPath!;
  //   final course = CoursesModel(
  //     image: imageData,
  //     coursetitle: addCourseTitle.text,
  //     Description: courseDescription.text,
  //     indroductionvideo: videoData,
  //   );
    
  //   addCourse(course);
  //   Navigator.pop(context);
  // }
}
