// import 'dart:developer';
// import 'dart:io';

// import 'package:coursepoint/DataBase/Functions/course_add_functions.dart';
// import 'package:coursepoint/DataBase/Functions/database_functions.dart';
// import 'package:coursepoint/DataBase/Model/courses_model.dart';
// import 'package:coursepoint/DataBase/Model/admin_model.dart';  // Import AdminModel
// import 'package:coursepoint/Screens/admin/add_courses/admin_add_course.dart';
// import 'package:coursepoint/Screens/admin/admin_screens/admin_account.dart';
// import 'package:coursepoint/Screens/admin/admin_screens/admin_course_details.dart';
// import 'package:coursepoint/widget/apppcolor.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class AdminhomeScreen extends StatefulWidget {
//   const AdminhomeScreen({super.key});
//   @override
//   State<AdminhomeScreen> createState() => _AdminhomeScreenState();
// }

// class _AdminhomeScreenState extends State<AdminhomeScreen> {
//   late TextEditingController searchController;
//   bool isSearchActive = false;
//   List<CoursesModel> filteredCourses = [];
  
  
//   @override
//   void initState() {
//     super.initState();
//     searchController = TextEditingController();
//     fechingCourseDetails();
//     filteredCourses = coursesListNotifier.value; // Initially, all courses
//     // loadAdminProfile();
    
//   }
//   void searchCourses(String query) {
//     setState(() {
//       filteredCourses = coursesListNotifier.value
//           .where((course) =>
//               course.coursetitle.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   void closeSearch() {
//     setState(() {
//       isSearchActive = false;
//       searchController.clear();
//       filteredCourses = coursesListNotifier.value; // Reset to all courses
//     });
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     int selectedIndex = 0;

//     return Scaffold(
//       // backgroundColor: const Color(0xFF191919),
//       appBar: AppBar(
//         backgroundColor:  appBarColor,
//         automaticallyImplyLeading: false,
//         title: Row(
//   children: [
//     // const SizedBox(width: 15),
//     Text('Home Screen',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)
    
//   ],
// ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: const Text(
//                     'All Courses',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 25,
//                         // fontWeight: FontWeight.bold
//                         ),
//                   ),
//                 ),
//                 const Spacer(),
//                 isSearchActive
//                     ? Expanded(
//                         flex: 4,
//                         child: TextField(
//                           controller: searchController,
//                           onChanged: searchCourses,
//                           style: TextStyle(color: appColorblack),
//                           decoration: const InputDecoration(
//                             hintText: 'Search...',
//                             hintStyle: TextStyle(color: Colors.grey),
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(Radius.circular(10))),
//                             filled: false,
//                             contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                           ),
//                         ),
//                       )
//                     : IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isSearchActive = true;
//                           });
//                         },
//                         icon: const Icon(
//                           Icons.search,
//                           size: 30,
//                           color: Colors.black,
//                         ),
//                       ),
//                 isSearchActive
//                     ? IconButton(
//                         onPressed: closeSearch,
//                         icon: const Icon(
//                           Icons.close,
//                           size: 30,
//                           color: Colors.black,
//                         ),
//                       )
//                     : Container(), // Empty container when search is not active
//               ],
//             ),
//             Expanded(
//               child: ValueListenableBuilder(
//                 valueListenable: coursesListNotifier,
//                 builder: (BuildContext ctx, List<CoursesModel> courseList,
//                     Widget? child) {
//                   final displayList = isSearchActive
//                       ? filteredCourses
//                       : courseList; // Display filtered or all courses
//                   return  courseList.isEmpty
//                   ? Center(
//                     child: Text('Course Not Available',
//                     style: TextStyle(color: appColorblack),
//                     ),
//                   ) 
                  
//                   : GridView.builder(
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 4,
//                       mainAxisSpacing: 4,
//                       mainAxisExtent: 210
//                     ),
//                     itemCount: displayList.length,
//                     itemBuilder: (ctx, index) {
//                       final course = displayList[index];
//                       return GestureDetector(
//                         onTap: () {
//                           log(course.id ?? 'id is null');
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (ctx) => AdmincoursedetailsScreen(
//                                     courseDetails: course,
//                                   )));
//                         },
//                         child: Card(
//                           elevation: 10,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                           color: appBarColor,
//                           child: Column(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(12.0),
//                                   topRight: Radius.circular(12.0),
//                                 ),
//                                 child: Image.file(File(course.image),
//                                 height: 130,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                                 ),
                                
                                
//                               ),
//                               SizedBox(height: 8,),
//                               Padding(padding: EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Expanded(child: Text(
//                                     course.coursetitle,
//                                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
//                                     overflow: TextOverflow.ellipsis,
//                                     )),
//                                     const SizedBox(width: 10,),
//                                     Container(
//                                       height: 40,
//                                       width: 40,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white54,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: const Icon(Icons.arrow_forward_ios,size: 16,),
//                                     )
//                                 ],
//                               ),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Column(
        
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // const Divider(color: Colors.grey),
//           BottomNavigationBar(
//             backgroundColor: appBarColor,
//             type: BottomNavigationBarType.fixed,
//             // backgroundColor: const Color(0xFF191919),
//             currentIndex: selectedIndex,
//             selectedItemColor: Colors.black,
//             unselectedItemColor: Colors.black,
//             showSelectedLabels: true,
//             iconSize: 30,
//             onTap: (index) {
//               setState(() {
//                 selectedIndex = index;
//               });
//               if (index == 1) {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (ctx) => const AdminaddcourseScreen()));
//               } else if (index == 2) {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (ctx) => const AdminAccountScreen()));
//               }
//             },
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.add),
//                 label: 'Add',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person_sharp,),
//                 label: 'Account',
                
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

// }






import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:coursepoint/DataBase/Functions/course_add_functions.dart';
import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/DataBase/Model/admin_model.dart';  // Import AdminModel
import 'package:coursepoint/Screens/admin/add_courses/admin_add_course.dart';
import 'package:coursepoint/Screens/admin/admin_screens/admin_account.dart';
import 'package:coursepoint/Screens/admin/admin_screens/admin_course_details.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminhomeScreen extends StatefulWidget {
  const AdminhomeScreen({super.key});
  @override
  State<AdminhomeScreen> createState() => _AdminhomeScreenState();
}

class _AdminhomeScreenState extends State<AdminhomeScreen> {
  late TextEditingController searchController;
  bool isSearchActive = false;
  List<CoursesModel> filteredCourses = [];
  
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    fechingCourseDetails();
    filteredCourses = coursesListNotifier.value; // Initially, all courses
    // loadAdminProfile();
  }
  
  void searchCourses(String query) {
    setState(() {
      filteredCourses = coursesListNotifier.value
          .where((course) =>
              course.coursetitle.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void closeSearch() {
    setState(() {
      isSearchActive = false;
      searchController.clear();
      filteredCourses = coursesListNotifier.value; // Reset to all courses
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text('Home Screen', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'All Courses',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
                const Spacer(),
                isSearchActive
                    ? Expanded(
                        flex: 4,
                        child: TextField(
                          controller: searchController,
                          onChanged: searchCourses,
                          style: TextStyle(color: appColorblack),
                          decoration: const InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            filled: false,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            isSearchActive = true;
                          });
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                isSearchActive
                    ? IconButton(
                        onPressed: closeSearch,
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.black,
                        ),
                      )
                    : Container(), // Empty container when search is not active
              ],
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: coursesListNotifier,
                builder: (BuildContext ctx, List<CoursesModel> courseList,
                    Widget? child) {
                  final displayList = isSearchActive
                      ? filteredCourses
                      : courseList; // Display filtered or all courses
                  return courseList.isEmpty
                    ? Center(
                        child: Text('Course Not Available',
                        style: TextStyle(color: appColorblack),
                        ),
                      ) 
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          mainAxisExtent: 210
                        ),
                        itemCount: displayList.length,
                        itemBuilder: (ctx, index) {
                          final course = displayList[index];
                          return GestureDetector(
                            onTap: () {
                              log(course.id ?? 'id is null');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => AdmincoursedetailsScreen(
                                        courseDetails: course,
                                      )));
                            },
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              color: appBarColor,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0),
                                    ),
                                    child: _buildCourseImage(course.image),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            course.coursetitle,
                                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white54,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Icon(Icons.arrow_forward_ios, size: 16),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomNavigationBar(
            backgroundColor: appBarColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            iconSize: 30,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
              if (index == 1) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const AdminaddcourseScreen()));
              } else if (index == 2) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const AdminAccountScreen()));
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_sharp),
                label: 'Account',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to handle cross-platform image display
  // Widget _buildCourseImage(String imageSource) {
  //   // Check if we're running on web
  //   if (kIsWeb) {
  //     // Check if the image is in base64 format (from web upload)
  //     if (imageSource.startsWith('data:image') || 
  //         (imageSource.length > 200 && !imageSource.contains('/'))) {
  //       try {
  //         // Try to decode as base64
  //         final imageData = imageSource.contains(',') 
  //             ? imageSource.split(',')[1] 
  //             : imageSource;
  //         return Image.memory(
  //           base64Decode(imageData),
  //           height: 130,
  //           width: double.infinity,
  //           fit: BoxFit.cover,
  //           errorBuilder: (context, error, stackTrace) {
  //             print('Error loading image: $error');
  //             return _buildErrorPlaceholder();
  //           },
  //         );
  //       } catch (e) {
  //         print('Error decoding base64 image: $e');
  //         return _buildErrorPlaceholder();
  //       }
  //     } else {
  //       // For web, display a placeholder if it's a file path
  //       return _buildErrorPlaceholder();
  //     }
  //   } else {
  //     // For mobile, use File
  //     return Image.file(
  //       File(imageSource),
  //       height: 130,
  //       width: double.infinity,
  //       fit: BoxFit.cover,
  //       errorBuilder: (context, error, stackTrace) {
  //         print('Error loading image file: $error');
  //         return _buildErrorPlaceholder();
  //       },
  //     );
  //   }
  // }


  // 2. Now, let's update the AdminhomeScreen to display images correctly:

// Add this helper method in your _AdminhomeScreenState class:
Widget _buildCourseImage(String imageSource) {
  if (imageSource.startsWith('BASE64:')) {
    // Handle base64 image data (from web)
    try {
      final base64Data = imageSource.substring(7); // Remove the "BASE64:" prefix
      return Image.memory(
        base64Decode(base64Data),
        height: 130,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading base64 image: $error');
          return _buildErrorPlaceholder();
        },
      );
    } catch (e) {
      print('Error decoding base64 image: $e');
      return _buildErrorPlaceholder();
    }
  } else {
    // Handle file paths (from mobile)
    if (kIsWeb) {
      // On web, we can't use File directly for paths from mobile
      return _buildErrorPlaceholder();
    } else {
      // On mobile, use File for the path
      try {
        return Image.file(
          File(imageSource),
          height: 130,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print('Error loading image file: $error');
            return _buildErrorPlaceholder();
          },
        );
      } catch (e) {
        print('Error loading file image: $e');
        return _buildErrorPlaceholder();
      }
    }
  }
}

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

  Widget _buildErrorPlaceholder() {
  return Container(
    height: 130,
    width: double.infinity,
    color: Colors.grey[300],
    child: const Center(
      child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
    ),
  );
}
}
