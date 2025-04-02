
import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Functions/delete_function.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
import 'package:coursepoint/Screens/admin/add_courses/admin_add_playlist.dart';
import 'package:coursepoint/Screens/admin/admin_screens/admin_notes.dart';
import 'package:coursepoint/screens/admin/update/update_subcourse_details.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
// import 'package:coursepoint/screens/admin/admin_add_playlist.dart';
// import 'package:coursepoint/screens/admin/admin_notes.dart';
import 'package:flutter/material.dart';

class AdminCoursePlayListScreen extends StatelessWidget {
  const AdminCoursePlayListScreen({super.key,required this.subcourse});
  final SubcourseModel subcourse;
  
  @override
  Widget build(BuildContext context) {
    fechingPlayListDetails();
    return Scaffold(
      
      // appBar: AppBar(
      //   // iconTheme: const IconThemeData(color: Colors.grey),
      //   backgroundColor: appBarColor,
      //   title: Text('Playlist', style: TextStyle(color: appColorblack, fontWeight: FontWeight.bold),),
      //   centerTitle: true,
        
      // ),
            appBar: CustomAppBar(title: 'Playlist', backgroundColor: appBarColor, titleColor: appColorblack),

      body: Padding(padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text("Playlist",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          
          ValueListenableBuilder(
            valueListenable: playListNotifier,
            builder: (BuildContext ctx, List<PlaylistModel>playListCourseList, Widget? child){
              final filterdList = playListCourseList.where((play){
                if(play.id != null ){
                  // log('subcourseid : ${play.subcourseId}');
                  return play.subcourseId == subcourse.id;
                }
                return false;
              }).toList();
              return 
              Expanded(
                child: playListCourseList.isEmpty
                ? Center(child: Text('Playlist Not Available'),)
                :ListView.builder(
                  itemCount: filterdList.length,
                  itemBuilder: (context, index) {
                    
                    final playListData = filterdList[index];
                  return Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AdminNotesScreen(playlistDetails: playListData,)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Container(
                              height: 70,
                              decoration:  BoxDecoration(color: Colors.blueGrey.shade100,borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow( color: Colors.black.withOpacity(0.2), spreadRadius: 2, blurRadius: 5,offset: Offset(3, 3))] ),
                              child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Icon(Icons.playlist_play,),
                                  
                                ),
                                const SizedBox(width: 80,),
                                Text(playListData.plalistTitle,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),)
                              ],
                            ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,)
                      ],
                    )
                  );
                },),
              );
            }
           
          ),
          

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical:10),
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add update logic
                      showDialog(
                  context: context, 
                  builder: (context) => UpdateSubcourseDetails(subcourseDetails: subcourse ,)
                );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors. blueGrey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:   Text('Update',style: TextStyle(color: appColorblack),),
                  ),
                  
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => AdminAddPlaylistScreen( subcourse: subcourse,)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:  Text('+ Add Playlist',style: TextStyle(color: appColorblack),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add delete logic
                      showDialog(
                        context: context, 
                        builder: (ctx) {
                          return AlertDialog(
                            content: const Text('Are you sure to remove this sub-course'),   
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text('Close')),
                              TextButton(onPressed: (){
                                deleteSubCourse(subcourse.id!);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }, child: Text('Delete'))
                            
                            ],
                          );
                        },);
                      
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:  Text('Delete',style: TextStyle(color: appColorblack),),
                  ),
                ],
              ),
            ),

        ],
      ),
      
      ),
    );
  }
}