import 'dart:io';

import 'package:coursepoint/DataBase/Functions/update_functions.dart';
import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateSubcourseDetails extends StatefulWidget {
  const UpdateSubcourseDetails({super.key,required this.subcourseDetails});
  final SubcourseModel subcourseDetails;
  @override
  State<UpdateSubcourseDetails> createState() => _UpdateSubcourseDetailsState();
}

class _UpdateSubcourseDetailsState extends State<UpdateSubcourseDetails> {

  final ImagePicker imagePicker = ImagePicker();
  String? image;
  final subcourseTitle = TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subcourseTitle.text = widget.subcourseDetails.subcoursetitle;
    image = widget.subcourseDetails.subcourseimage;
  }
  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text('Update',style: TextStyle(fontSize: 20),),
              const SizedBox(height: 20,),
              const Text('Update Sub Course Image',style: TextStyle(fontSize: 15),),
              const SizedBox(height: 10,),
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
              SizedBox(height: 20,),
              Text('Update Sub Course Title'),
              SizedBox(height: 10,),
          
              TextFormField(
                controller: subcourseTitle,
                validator: (value) {
                  if(value == null || value.trim().length<3){
                    return 'Must be at least 3 characters long';
                  }
                  return null;
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
                  SizedBox(width: 10,),
                  TextButton(onPressed: (){
                    submitSubcourse();
                  }, 
                  child: Text('Submit')
                  )
                ],
              )
          
            ],
          ),
        ),
      ),
    );
  }


  void submitSubcourse(){
    
    if(!_formKey.currentState!.validate() || image == null ){
    return ;
    }

    final subcourse = SubcourseModel(
      subcourseimage: image!, 
      subcoursetitle: subcourseTitle.text, 
      courseId: widget.subcourseDetails.courseId, 
      id:widget.subcourseDetails.id);
      updateSubCourse(subcourse);

    Navigator.pop(context);
    Navigator.pop(context);
  }

  Future<void> imagepickgallery ()async{
    final PickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if(PickedFile != null){
      setState(() {
        image = PickedFile.path;
      });
    }
  }

}