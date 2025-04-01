import 'dart:io';

import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Functions/update_functions.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class UpdatePlaylistDetails extends StatefulWidget {
  const UpdatePlaylistDetails({super.key,required this.playlistdetails});
  final PlaylistModel playlistdetails;
  @override
  State<UpdatePlaylistDetails> createState() => _UpdatePlaylistDetailsState();
}

class _UpdatePlaylistDetailsState extends State<UpdatePlaylistDetails> {
  final playListTitle = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  VideoPlayerController? videoController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? video;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fechingCourseDetails();
    playListTitle.text = widget.playlistdetails.plalistTitle;
    video = widget.playlistdetails.playlistVideo;

    if(video != null && video!.isNotEmpty){
      videoController = VideoPlayerController.file(File(video!))
      ..initialize().then((_){
        setState(() {
          videoController!.play();
        });
      });
    }
  }

  void dispose(){
    playListTitle.dispose();
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
            const  Text('Update',style: TextStyle(fontSize: 20),),
            const  SizedBox(height: 10,),

            Text('Update playlist image '),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                pickedVideo();
              },
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: videoController != null && videoController!.value.isInitialized
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: videoController!.value.aspectRatio,
                    child: VideoPlayer(videoController!),
                    ),
                )
                :const Center(
                  child: Text('Tap to select video'),
                )
              )
            ),
          
           const SizedBox(height: 10,),

           Text('Update playlist title ',),

           const SizedBox(height: 10),
          
           TextFormField(
            
            controller: playListTitle,
            validator: (value) {
              if(value == null || value.trim().length < 3){
                return 'Must be at least 3 characters long ';
              }
              return null ;
            },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, 
                child: Text('Cancel')),
          
                TextButton(onPressed: (){
                  submitPlaylist();
                }, 
                child: Text('Submit'))
          
              ],
            )
            
            ],
          ),
        ),
      ),
    );
  }

  Future <void> pickedVideo()async{
    final PickedVideoFile = await imagePicker.pickVideo(source: ImageSource.gallery);
    if(PickedVideoFile != null ){
      videoController?.dispose();
      videoController= VideoPlayerController.file(File(PickedVideoFile.path))
      ..initialize().then((_){
        setState(() {
          video = PickedVideoFile.path;
        });
        videoController!.play();
      });
    }
  }


  void submitPlaylist(){
    
    if (!_formKey.currentState!.validate() || videoController == null ){
      return ; 
    }

    final playlist = PlaylistModel(
      playlistVideo: video!, 
      plalistTitle: playListTitle.text, 
      subcourseId: widget.playlistdetails.subcourseId,
      id: widget.playlistdetails.id
      );
      updatePlaylist(playlist);

      Navigator.pop(context);
      Navigator.pop(context);

  }


}