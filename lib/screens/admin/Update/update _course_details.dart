
import 'dart:io';
import 'package:coursepoint/DataBase/Functions/update_functions.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
// import 'package:coursepoint/Screens/admin/admin_home.dart';
import 'package:coursepoint/Screens/admin/admin_screens/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class UpdateCourseDetails extends StatefulWidget {
  const UpdateCourseDetails({super.key, required this.coursedetails});
  final CoursesModel coursedetails;

  @override
  State<UpdateCourseDetails> createState() => _UpdateCourseDetailsState();
}

class _UpdateCourseDetailsState extends State<UpdateCourseDetails> {
  final titleController = TextEditingController();
  final discriptionController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  VideoPlayerController? videoController;
  String? video;
  String? image;

  @override
  void initState() {
    super.initState();
      
    titleController.text = widget.coursedetails.coursetitle;
    discriptionController.text = widget.coursedetails.Description;

    // Initialize image and video from database details
    image = widget.coursedetails.image;
    video = widget.coursedetails.indroductionvideo;

    if (video != null && video!.isNotEmpty) {
      videoController = VideoPlayerController.file(
        File(video!),
      )..initialize().then((_) {
          setState(() {
            videoController!.play();
          });
        });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    discriptionController.dispose();
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
              const Text('Update', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              const Text('Update Course Image', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: imagepickgallery,
                child: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    image: image != null
                        ? DecorationImage(
                            image: FileImage(File(image!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: image == null
                      ? const Center(
                          child: Text('Tap to select image'),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text('Course Title', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if(value == null || value.trim().length < 3){
                    return ' Must be at least 3 characters long';
                  }
                  return null;
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              const Text(
                'Course Introduction Video',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: pickVideo,
                child: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: videoController != null &&
                          videoController!.value.isInitialized
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: videoController!.value.aspectRatio,
                            child: VideoPlayer(videoController!),
                          ),
                        )
                      : const Center(
                          child: Text('Tap to select video'),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Course Description', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextFormField(
                controller: discriptionController,
                validator: (value) {
                  if(value == null || value.trim().length < 10){
                    return 'Must be at least 10 characters long ';
                  }
                  return null; 
                },
                maxLines: null,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, 
                  //style: TextButton.styleFrom(backgroundColor: Colors.grey),
                  child: Text('Cancel')),
                  SizedBox(width: 10,),
                  TextButton(
                    onPressed: () {
                      // if (titleController.text.isEmpty ||
                      //     discriptionController.text.isEmpty ||
                      //     image == null ||
                      //     video == null) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('All fields are required!'),
                      //     ),
                      //   );
                      //   return;
                      // }
                      if(!_formKey.currentState!.validate() || image == null || video == null){
                        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required! ')));
                         return;
                      }
                  
                      final course = CoursesModel(
                        id: widget.coursedetails.id,
                        image: image!, 
                        coursetitle: titleController.text, 
                        indroductionvideo: video!,
                        Description: discriptionController.text,
                        );
                        if(widget.coursedetails.id != null){
                          updateCourse(course);
                          print(course.coursetitle);
                        }else{
                          print('id is null');
                        }
                  
                        
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>AdminhomeScreen()));
                    },
                  //  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                    child: const Text(
                      'Submit',
                     
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> imagepickgallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = pickedFile.path;
      });
    }
  }

  Future<void> pickVideo() async {
    final pickedVideoFile =
        await imagePicker.pickVideo(source: ImageSource.gallery);
    if (pickedVideoFile != null) {
      videoController?.dispose();
      videoController = VideoPlayerController.file(File(pickedVideoFile.path))
        ..initialize().then((_) {
          setState(() {
            video = pickedVideoFile.path;
          });
          videoController!.play();
        });
    }
  }
}

