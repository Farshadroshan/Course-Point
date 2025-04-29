
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:coursepoint/DataBase/Functions/course_add_functions.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class AdminaddcourseScreen extends StatefulWidget {
  const AdminaddcourseScreen({super.key});

  @override
  State<AdminaddcourseScreen> createState() => _AdminaddcourseScreenState();
}

class _AdminaddcourseScreenState extends State<AdminaddcourseScreen> {
  String? imagePath;
  String? imageBase64;
  String? videoPath;
  Uint8List? videoBytes; // Store video bytes for web
  String? videoBase64; // Store video as base64 for web
  XFile? videoFile;
  bool isVideoLoading = false;
  final ImagePicker imagePicker = ImagePicker();
  final TextEditingController addCourseTitle = TextEditingController();
  final TextEditingController courseDescription = TextEditingController();
  VideoPlayerController? videoController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  
  @override
  void dispose() {
    videoController?.dispose();
    addCourseTitle.dispose();
    courseDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: appBarColor,
      //   title: const Text(
      //     'Add New Course',
      //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      //   ),
      //   centerTitle: true,
      // ),
      appBar: CustomAppBar(title: 'Add New Course', backgroundColor: appBarColor, titleColor: appColorblack),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSectionTitle("Course Image"),
                  buildImagePicker(),
                  buildSectionTitle("Course Title"),
                  buildTextField(addCourseTitle, "Enter course title", 3),
                  buildSectionTitle("Introduction Video"),
                  buildVideoPicker(),
                  buildSectionTitle("Course Description"),
                  buildDescriptionTextField(courseDescription, 'Enter the Description', _scrollController, 10),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => submitCourse(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint, int minLength) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value == null || value.trim().length < minLength) {
          return 'Must be at least $minLength characters long';
        }
        return null;
      },
    );
  }

  Widget buildDescriptionTextField(TextEditingController controller, String hint, ScrollController scrollController, int minLength) {
    return TextFormField(
      controller: controller,
      scrollController: scrollController,
      maxLines: null,
      minLines: 5,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
      validator:(value) {
        if(value == null || value.trim().length < minLength) {
          return 'Must be at least $minLength characters long';
        }
        return null;
      },
    );
  }

  Widget buildImagePicker() {
    return GestureDetector(
      onTap: () => pickImage(),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: imagePath != null || imageBase64 != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: kIsWeb
                    ? Image.memory(base64Decode(imageBase64!), fit: BoxFit.cover)
                    : Image.file(File(imagePath!), fit: BoxFit.cover),
              )
            : const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
      ),
    );
  }

  Widget buildVideoPicker() {
    return GestureDetector(
      onTap: () => pickVideo(),
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
    );
  }
  
  Future<void> pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          imageBase64 = base64Encode(bytes);
        });
      } else {
        setState(() {
          imagePath = pickedFile.path;
        });
      }
    }
  }

  Future<void> pickVideo() async {
    final pickedFile = await imagePicker.pickVideo(source: ImageSource.gallery);
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

  void submitCourse(BuildContext context) {
    if (!_formKey.currentState!.validate() || (imagePath == null && imageBase64 == null) || (videoPath == null && videoFile == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and add media')),
      );
      return;
    }
    // Use a special prefix to identify base64 images for web
  final imageData = kIsWeb 
      ? "BASE64:$imageBase64" 
      : imagePath!;
      
  final videoData = kIsWeb 
      ? "BASE64:$videoBase64" 
      : videoPath!;
    final course = CoursesModel(
      image: imageData,
      coursetitle: addCourseTitle.text,
      Description: courseDescription.text,
      indroductionvideo: videoData,
    );
    
    addCourse(course);
    Navigator.pop(context);
  }
}