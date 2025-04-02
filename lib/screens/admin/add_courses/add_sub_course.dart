
// import 'dart:io';
// import 'package:coursepoint/DataBase/Functions/course_add_functions.dart';
// import 'package:coursepoint/DataBase/Model/courses_model.dart';
// import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
// import 'package:coursepoint/widget/apppcolor.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AddSubCourseScreen extends StatefulWidget {
//   final CoursesModel course;
//   const AddSubCourseScreen({Key? key, required this.course}) : super(key: key);

//   @override
//   _AddSubCourseScreenState createState() => _AddSubCourseScreenState();
// }

// class _AddSubCourseScreenState extends State<AddSubCourseScreen> {
//   final ImagePicker _imagePicker = ImagePicker();
//   String? _subcourseImage;
//   final TextEditingController _subcourseTitleController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appBarColor,
//         centerTitle: true,
//         title: Text(
//           'Add Sub Course',
//           style: TextStyle(color: appColorblack, fontWeight: FontWeight.bold, fontSize: 22),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 "Add Sub Course Image",
//                 style: TextStyle(color: appColorblack, fontSize: 18, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 10),
        
//               GestureDetector(
//                 onTap: () async {
//                   await _pickImage();
//                   setState(() {});
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: Colors.blueGrey.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade400),
//                   ),
//                   child: _subcourseImage != null
//                       ? ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.file(File(_subcourseImage!), fit: BoxFit.cover),
//                         )
//                       : const Center(child: Icon(Icons.add_a_photo, color: Colors.grey, size: 40)),
//                 ),
//               ),
//               const SizedBox(height: 20),
        
//               Text(
//                 "Add Sub Course Title",
//                 style: TextStyle(color: appColorblack, fontSize: 18, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 10),
        
//               Form(
//                 key: _formKey,
//                 child: TextFormField(
//                   controller: _subcourseTitleController,
//                   cursorColor: Colors.grey,
//                   validator: (value) {
//                     if(value == null || value.trim().isEmpty){
//                       return 'Title cannot be emty';
//                     }else if (value.trim().length<3){
//                       return 'Must be at least 3 characters long';
//                     }
//                     return null;
//                   },
//                   style: TextStyle(color: appColorblack),
//                   decoration: InputDecoration(
//                     hintText: 'Enter sub-course title',
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey.shade400),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.blue),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
        
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue, 
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     elevation: 3,
//                   ),
//                   onPressed: () => _submitSubCourse(context),
//                   icon: const Icon(Icons.check, color: Colors.white),
//                   label: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 18)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _subcourseImage = pickedFile.path;
//       });
//     } else {
//       print('No image selected');
//     }
//   }

//   void _submitSubCourse(BuildContext context) {
//     if (!_formKey.currentState!.validate() || _subcourseImage == null ) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Please fill all fields and add an image'),
//           backgroundColor: Colors.black,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//       return;
//     }

//     final subcourse = SubcourseModel(
//       subcourseimage: _subcourseImage!,
//       subcoursetitle: _subcourseTitleController.text,
//       courseId: widget.course.id!,
//     );

//     AddSubCourse(subcourse);
//     Navigator.pop(context);
//   }
// }




import 'dart:io';
import 'package:coursepoint/DataBase/Functions/course_add_functions.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

class AddSubCourseScreen extends StatefulWidget {
  final CoursesModel course;
  const AddSubCourseScreen({Key? key, required this.course}) : super(key: key);

  @override
  _AddSubCourseScreenState createState() => _AddSubCourseScreenState();
}

class _AddSubCourseScreenState extends State<AddSubCourseScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  String? _subcourseImage;
  final TextEditingController _subcourseTitleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: appBarColor,
      //   centerTitle: true,
      //   title: Text(
      //     'Add Sub Course',
      //     style: TextStyle(color: appColorblack, fontWeight: FontWeight.bold, fontSize: 22),
      //   ),
      // ),
      appBar: CustomAppBar(title: 'Add sub course', backgroundColor: appBarColor, titleColor: appColorblack,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add Sub Course Image",
                style: TextStyle(color: appColorblack, fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: () async {
                  await _pickImage();
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: _subcourseImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: kIsWeb
                              ? Image.network(_subcourseImage!, fit: BoxFit.cover)
                              : Image.file(File(_subcourseImage!), fit: BoxFit.cover),
                        )
                      : const Center(child: Icon(Icons.add_a_photo, color: Colors.grey, size: 40)),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                "Add Sub Course Title",
                style: TextStyle(color: appColorblack, fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),

              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _subcourseTitleController,
                  cursorColor: Colors.grey,
                  validator: (value) {
                    if(value == null || value.trim().isEmpty){
                      return 'Title cannot be empty';
                    }else if (value.trim().length < 3){
                      return 'Must be at least 3 characters long';
                    }
                    return null;
                  },
                  style: TextStyle(color: appColorblack),
                  decoration: InputDecoration(
                    hintText: 'Enter sub-course title',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                  ),
                  onPressed: () => _submitSubCourse(context),
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _subcourseImage = pickedFile.path;
      });
    } else {
      print('No image selected');
    }
  }

  void _submitSubCourse(BuildContext context) {
    if (!_formKey.currentState!.validate() || _subcourseImage == null ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all fields and add an image'),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final subcourse = SubcourseModel(
      subcourseimage: _subcourseImage!,
      subcoursetitle: _subcourseTitleController.text,
      courseId: widget.course.id!,
    );

    AddSubCourse(subcourse);
    Navigator.pop(context);
  }
}
