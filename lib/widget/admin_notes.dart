

import 'dart:developer';

import 'package:coursepoint/DataBase/Model/note_model.dart';
import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/Screens/admin/admin_screens/admin_notes.dart';
import 'package:coursepoint/widget/apppcolor.dart';

import 'package:flutter/material.dart';

class AdminNotes extends StatelessWidget {
  const AdminNotes({
    super.key,
    required this.widget,
  });

  final AdminNotesScreen widget;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: noteListNotifier,
      builder: (BuildContext ctx, List<NoteModel>notecourseList, Widget? child){
        final filterdList = notecourseList.where((note){
          if(note.id != null){
            log('playlistID: ${note.playlistId}');
            log('noteID: ${note.id}');
            return note.playlistId == widget.playlistDetails.id;
          }
          return false;
        }).toList();
        return Expanded(
          child: 
          notecourseList.isEmpty
        ? Center(child: Text('Playlist Not Available'),)
        :ListView.builder(
            itemCount: filterdList.length,
              itemBuilder: (context, index) {
                final noteDetails = filterdList[index];
                return Padding(
                  padding:  const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ExpansionTile(
                    title:  Text(
                    noteDetails.notequestion,
                      style:  TextStyle(
                        fontSize: 20,
                        color: appColorblack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing:  Icon(Icons.arrow_drop_down,color: appColorblack,),
                    
                    tilePadding:  const EdgeInsets.all(0),
                    children: [
                      ListBody(
                        children: [
                          Text.rich(
                            TextSpan(
                               text: noteDetails.noteAnswer,
                              style: TextStyle(
                                  fontSize: 18, color: appColorblack,fontWeight: FontWeight.w400),
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