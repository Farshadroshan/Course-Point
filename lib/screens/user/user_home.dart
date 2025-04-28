
// import 'dart:convert';
// import 'dart:io';
import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
// import 'package:coursepoint/Screens/user/user_course_details.dart';
import 'package:coursepoint/Screens/user/user_menu.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
import 'package:coursepoint/screens/user/user_chatbot_page.dart';
import 'package:coursepoint/widget/apppcolor.dart';
// import 'package:coursepoint/widget/chat_bot_button_widget.dart';
import 'package:coursepoint/widget/colors.dart';
import 'package:coursepoint/widget/user_course_grid_view_widget.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserhomeScreen extends StatefulWidget {
  const UserhomeScreen({super.key, required this.userLogindata});
  final UserLoginModel userLogindata;

  @override
  State<UserhomeScreen> createState() => _UserhomeScreenState();
}

class _UserhomeScreenState extends State<UserhomeScreen> {
  late TextEditingController searchController;
  bool isSearchActive = false;
  List<CoursesModel> filteredCourses = [];
  String userName = 'Guest';

  void searchCourse(String query) {
    setState(() {
      filteredCourses = coursesListNotifier.value
          .where((course) => course.coursetitle.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  void closeSearch() {
    setState(() {
      isSearchActive = false;
      searchController.clear();
      filteredCourses = coursesListNotifier.value;
    });
  }
  

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    // fetchUserName();
    filteredCourses = coursesListNotifier.value;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => UsermenuScreen(userLoginId: widget.userLogindata,)));
              },
              icon: Icon(Icons.menu, size: 30, color: appColorblack)
            ),
            Text(widget.userLogindata.name, style: TextStyle(color: appColorblack, fontWeight: FontWeight.bold)),
          ],
        ),
        
        
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
               ChatBotBox(widget: widget),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('All Courses', style: TextStyle(color: Mycolors.black, fontSize: 25, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                isSearchActive
                    ? Expanded(
                        flex: 4,
                        child: TextField(
                          controller: searchController,
                          onChanged: searchCourse,
                          style: const TextStyle(color: Mycolors.black),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            isSearchActive = true;
                          });
                        },
                        icon: const Icon(Icons.search, size: 30, color: Mycolors.black),
                      ),
                isSearchActive
                    ? IconButton(
                        onPressed: closeSearch,
                        icon: const Icon(Icons.close, size: 30, color: Mycolors.black),
                      )
                    : Container(),
              ],
            ),
            
              CourseGridViewWidget(filteredCourses: filteredCourses, isSearchActive: isSearchActive, userLogindata: widget.userLogindata),
              // child: ValueListenableBuilder(
              //   valueListenable: coursesListNotifier,
              //   builder: (BuildContext ctx, List<CoursesModel> courseList, Widget? child) {
              //     final displayList = isSearchActive ? filteredCourses : courseList;
              //     return courseList.isEmpty
              //       ? Center(
              //         child: Text('Course Not Available',style: TextStyle(color: appColorblack),),
              //       )
                  
              //       : GridView.builder(
              //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         crossAxisSpacing: 4,
              //         mainAxisSpacing: 4,
              //         mainAxisExtent: 210,
              //       ),
              //       itemCount: displayList.length,
              //       itemBuilder: (ctx, index) {
              //         final courseUser  = displayList[index];
              //         // Get a color from the list based on the index
              //         // Color cardColor = cardColors[index % cardColors.length];
              //         return GestureDetector(
              //           onTap: () {
              //             Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => UsercoursedetailsScreen(courseDetails: courseUser , userData: widget.userLogindata,)));
              //           },
              //           child: Card(
              //             elevation: 10,
                          
              //             // shadowColor: Colors.white70,
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              //             color:     appBarColor,
              //             child: Column(
              //               children: [
              //                 ClipRRect(
              //                   borderRadius: const BorderRadius.only(
              //                     topLeft: Radius.circular(12.0),
              //                     topRight: Radius.circular(12.0),
              //                   ),
              //                   // child: Image.file(
              //                   //   File(courseUser .image),
              //                   //   height: 130,
              //                   //   width: double.infinity,
              //                   //   fit: BoxFit.cover,
              //                   // ),
              //                   child: _buildCourseImage(courseUser.image)
              //                 ),
              //                 SizedBox(height: 8,),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Row(
              //                     children: [
              //                       Expanded(
              //                         child: Text(
              //                           courseUser .coursetitle,
              //                           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black), // Change text color for better contrast
              //                           overflow: TextOverflow.ellipsis,
              //                         ),
              //                       ),
              //                       const SizedBox(width: 10),
              //                       Container(
              //                         width: 40,
              //                         height: 40,
              //                         decoration: BoxDecoration(
              //                           color: Colors.white54, // Change this to your desired color
              //                           borderRadius: BorderRadius.circular(10),
              //                         ),
              //                         child: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black), // Change icon color for better contrast
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   },
              // ),
               
            
          ],
        ),
      ),
    );
  }

//   Widget _buildCourseImage(String imageSource) {
//   if (imageSource.startsWith('BASE64:')) {
//     // Handle base64 image data (from web)
//     try {
//       final base64Data = imageSource.substring(7); // Remove the "BASE64:" prefix
//       return Image.memory(
//         base64Decode(base64Data),
//         height: 130,
//         width: double.infinity,
//         fit: BoxFit.cover,
//         errorBuilder: (context, error, stackTrace) {
//           print('Error loading base64 image: $error');
//           return _buildErrorPlaceholder();
//         },
//       );
//     } catch (e) {
//       print('Error decoding base64 image: $e');
//       return _buildErrorPlaceholder();
//     }
//   } else {
//     // Handle file paths (from mobile)
//     if (kIsWeb) {
//       // On web, we can't use File directly for paths from mobile
//       return _buildErrorPlaceholder();
//     } else {
//       // On mobile, use File for the path
//       try {
//         return Image.file(
//           File(imageSource),
//           height: 130,
//           width: double.infinity,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) {
//             print('Error loading image file: $error');
//             return _buildErrorPlaceholder();
//           },
//         );
//       } catch (e) {
//         print('Error loading file image: $e');
//         return _buildErrorPlaceholder();
//       }
//     }
//   }
// }


// Widget _buildErrorPlaceholder() {
//   return Container(
//     height: 130,
//     width: double.infinity,
//     color: Colors.grey[300],
//     child: const Center(
//       child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
//     ),
//   );
// }
}

class ChatBotBox extends StatelessWidget {
  const ChatBotBox({
    super.key,
    required this.widget,
  });

  final UserhomeScreen widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
       onTap: () {
         
       },
        child: 
       
       Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/robot_text.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
    
          // Chatbot title & button
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Chat with AI',
                  style: TextStyle(
     fontSize: 22,
     color: Colors.white,
     fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
     // Navigate to chatbot screen
     Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ChatScreen(userId: widget.userLogindata.id!)));
                  },
                  child: Container(
     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
     decoration: BoxDecoration(
       color: Colors.blueAccent,
       borderRadius: BorderRadius.circular(10),
       boxShadow: [
         BoxShadow(
           color: Colors.blueAccent.withOpacity(0.5),
           blurRadius: 5,
           spreadRadius: 1,
         ),
       ],
     ),
     child: Text(
       'Click here',
       style: TextStyle(
         fontSize: 18,
         color: Colors.white,
         fontWeight: FontWeight.w600,
       ),
     ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    
      ),
    );
  }
}


























































































































































































































// import 'dart:io';

// import 'package:coursepoint/DataBase/Functions/database_functions.dart';
// import 'package:coursepoint/DataBase/Model/courses_model.dart';
// // import 'package:coursepoint/DataBase/Model/data_model.dart';
// import 'package:coursepoint/Screens/user/user_course_details.dart';
// import 'package:coursepoint/Screens/user/user_menu.dart';
// import 'package:coursepoint/database/model/user_details_model.dart';
// import 'package:coursepoint/database/model/user_login_model.dart';
// import 'package:coursepoint/widget/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class UserhomeScreen extends StatefulWidget {
//   const UserhomeScreen({super.key,required this.userLogindata});
//   final UserLoginModel userLogindata;
  
//   @override
//   State<UserhomeScreen> createState() => _UserhomeScreenState();
  
// }


// class _UserhomeScreenState extends State<UserhomeScreen> {

//   late TextEditingController searchController;
//   bool isSearchActive = false;
//   List<CoursesModel> filteredCourses = [];
//   String userName = 'Guest';
//   void searchCourse(String query){
//     setState(() {
//       filteredCourses = coursesListNotifier.value
//         .where((course) => 
//           course.coursetitle.toLowerCase().contains(query.toLowerCase()))
//         .toList();
      
//     });
//   }

//   void fetchUserName() async {
//   final userBox = await Hive.openBox<UserDetailsModel>('userDetails');

//   if (userBox.isNotEmpty) {
//     final userDetails = userBox.get(widget.userLogindata.id);
//     if (userDetails != null) {
//       setState(() {
//         userName = userDetails.name;
//       });
//     }
//   }

//   // Listen for changes in the Hive box
//   userBox.watch().listen((event) {
//     final updatedUserDetails = userBox.get(widget.userLogindata.id);
//     if (updatedUserDetails != null) {
//       setState(() {
//         userName = updatedUserDetails.name;
//       });
//     }
//   });
// }


//   void closeSearch(){
//     setState(() {
//       isSearchActive = false;
//       searchController.clear();
//       filteredCourses = coursesListNotifier.value;
      
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     searchController = TextEditingController();
//     fechingCourseDetails();
//     filteredCourses = coursesListNotifier.value;
//     fetchUserName();
//   }

//   @override
//   void dispose(){
//     searchController.dispose();
//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {

//     // final userBox = Hive.box<UserLoginModel>('userBox');
//     // final userDetails = userBox.get('userDetails');
    
//     //  final userName = userDetails?.password ?? 'Guest';

//     return Scaffold(
//       //  backgroundColor: const Color(0xFF191919),
//       appBar: AppBar(
//         // backgroundColor: const Color(0xFF191919),
//         automaticallyImplyLeading: false,
//         title: Row(
//             children: [
//               IconButton(onPressed: (){
//                 Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>UsermenuScreen(userLoginId: widget.userLogindata,)));
//               },
//               icon: const Icon(Icons.menu,size: 30,color: Mycolors.grey,)),
//               const CircleAvatar(radius: 25,
//               backgroundImage: AssetImage("assets/Avatar.png"),
//               backgroundColor: Colors.black,
//               ),
//               const SizedBox(width: 10,),
//               Text(userName,style: const TextStyle(color: Colors.white,fontWeight:  FontWeight.bold),)
//             ],
//           ),
        
      
//           bottom: PreferredSize(preferredSize: const Size.fromHeight(5.0), 
//           child: Container(
//             color: Colors.grey,
//             height: 1.0,
//           )),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           // decoration: BoxDecoration(color: Colors.teal),
//           child: Column(
//             children: [
//                 // const ProgressCard(),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: const Text('All Courses',style: TextStyle(color: Mycolors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                     ),
//                     const Spacer(),
//                     isSearchActive
//                     ? Expanded(
//                       flex: 4,
//                       child: TextField(
//                       controller: searchController,
//                       onChanged: searchCourse,
//                       style: const TextStyle(color: Mycolors.black),
//                       decoration: const InputDecoration(

//                         hintText: 'Search...',
//                         hintStyle: TextStyle(color: Colors.grey),
//                         border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//                         filled: false,
//                         contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        
//                       ),
//                     )
//                     )
//                     :IconButton(onPressed: (){
//                       setState(() {
//                         isSearchActive = true;
//                       });
//                     }, icon: const Icon(
//                       Icons.search,
//                       size: 30,
//                       color: Mycolors.black,
//                     ),
//                     ),
//                     isSearchActive
//                     ? IconButton(onPressed: (){
//                       closeSearch();
//                     }, icon: const Icon(
//                       Icons.close,
//                       size: 30,
//                       color: Mycolors.black,
//                     ))
//                     :Container(),
//                   ],
//                 ),
               
            

//                 Expanded(
//                   child: ValueListenableBuilder(
//                     valueListenable: coursesListNotifier,
//                     builder: (BuildContext ctx,List<CoursesModel> courseList,Widget? child, ){
//                       final displayList = isSearchActive
//                       ? filteredCourses
//                       : courseList;
//                       return GridView.builder(
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 4,
//                             mainAxisSpacing: 4,
//                             mainAxisExtent: 210,
//                             ),
                    
//                           itemCount: displayList.length,
                      
//                           itemBuilder: (ctx,index){
//                            final courseuser= displayList[index];
//                             return GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>UsercoursedetailsScreen(courseDetails: courseuser,userData: widget.userLogindata,)));
//                               },
//                               child: Card(
//                                  child: Column(
//                                    children: [
//                                      ClipRRect(
//                                       borderRadius: const BorderRadius.only(
//                                         topLeft: Radius.circular(12.0),
//                                         topRight: Radius.circular(12.0),
//                                         ),
//                                       child: Image(image: FileImage(File(courseuser.image)),
//                                       height: 130,
//                                       width: double.infinity,
//                                       fit: BoxFit.cover,
//                                       ),
//                                      ),
//                                      Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(courseuser.coursetitle,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, ),),
//                                         ),
//                                         Spacer(),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Container(
                                          
//                                             width: 50,
//                                             height: 50,
//                                             decoration: BoxDecoration(color: const Color.fromARGB(147, 218, 236, 255),borderRadius: BorderRadius.circular(10)),
//                                             child: Icon(Icons.arrow_back_ios_new),
//                                           ),
//                                         ),
//                                       ],
//                                      )
//                                    ],
//                                  ),
//                               //   child: SizedBox(
//                               //     child: Column(
//                               //       crossAxisAlignment: CrossAxisAlignment.start,
//                               //       children: [
//                               //         Padding(
//                               //           padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
//                               //           child: Text(courseuser.coursetitle,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                        
//                               //         ),
//                               //         Padding(
//                               //           padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                               //           child: Container(
//                               //             width: 200,
//                               //             height: 120,
//                               //             decoration: BoxDecoration(
//                               //               image: DecorationImage(image: FileImage(File(courseuser.image)),fit: BoxFit.cover),
//                               //               color: Colors.grey,borderRadius: BorderRadius.circular(10)),
                                          
//                               //           ),
//                               //         )
//                               //       ],
//                               //     ),
//                               //   ),
//                               ),
//                             );
//                           }
                          
//                           );
//                     }
                    
//                   ),
//                 )
              
//             ],
//           ),
//         ),

//       ),

      
      
//     );
//   }
// }



////////////////////////////////////////////////////////////////////
