
import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/screens/user/user_course_notes.dart';
import 'package:coursepoint/DataBase/Model/note_model.dart';
import 'package:coursepoint/widget/apppcolor.dart';

import 'package:flutter/material.dart';

class UserNotes extends StatelessWidget {
  const UserNotes({
    super.key,
    required this.widget,
  });

  final UsercoursenotesScreen widget;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
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
    );
  }
}

