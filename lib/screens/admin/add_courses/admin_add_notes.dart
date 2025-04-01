
import 'package:coursepoint/DataBase/Functions/course_add_functions.dart';
import 'package:coursepoint/DataBase/Model/note_model.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:flutter/material.dart';

class AdminaddnotesScreen extends StatefulWidget {
  final PlaylistModel playlist;
  AdminaddnotesScreen({super.key, required this.playlist});

  @override
  _AdminaddnotesScreenState createState() => _AdminaddnotesScreenState();
}

class _AdminaddnotesScreenState extends State<AdminaddnotesScreen> {
  final TextEditingController addQuestion = TextEditingController();
  final TextEditingController addAnswer = TextEditingController();
  final ScrollController _scrollController = ScrollController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    addAnswer.addListener(_scrollToBottom);
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    addAnswer.removeListener(_scrollToBottom);
    addQuestion.dispose();
    addAnswer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void submitnotes(BuildContext context) {
    // if (addQuestion.text.trim().isEmpty || addAnswer.text.trim().isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Please fill the fields')),
    //   );
    //   return;
    // }

    if(!_formKey.currentState!.validate()){
      return ; 
    }
    final notesData = NoteModel(
      notequestion: addQuestion.text,
      noteAnswer: addAnswer.text,
      playlistId: widget.playlist.id!,
    );

    addnotes(notesData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text(
          'Add Notes',
          style: TextStyle(
              color: appColorblack, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Add Question", style: TextStyle(color: appColorblack, fontSize: 20)),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: addQuestion,
                        maxLines: null,
                        minLines: 2,
                        cursorColor: Colors.grey,
                        style: TextStyle(color: appColorblack),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {
                          if(value == null || value.trim().length < 3){
                            return 'Must be at least 3 characters long';
                          }
                          return null ; 
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("Add Answer", style: TextStyle(color: appColorblack, fontSize: 20)),
                    const SizedBox(height: 10),
                        
                    /// Fixed TextFormField with proper height & scrolling
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                    // Increased height
                        child: TextFormField(
                          controller: addAnswer,
                          scrollController: _scrollController,
                          cursorColor: Colors.grey,
                          maxLines: null,
                          minLines: 5,
                          // expands: true,
                          style: TextStyle(color: appColorblack),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                          ),
                          validator: (value) {
                            if( value == null || value.trim().length < 10){
                              return 'Must be at least 10 characters long';
                            }
                            return null ;
                          },
                        ),
                      
                    ),
                        
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        submitnotes(context);
                      },
                      child: const Text("Submit", style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
