
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AdminEnrollmentsScreen extends StatefulWidget {
  @override
  _AdminEnrollmentsScreenState createState() => _AdminEnrollmentsScreenState();
}

class _AdminEnrollmentsScreenState extends State<AdminEnrollmentsScreen> {
  List<Map<String, String>> enrollments = [];
  List<Map<String, String>> filteredEnrollments = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchEnrollments();
  }

  void filterEnrollments(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredEnrollments = enrollments;
      } else {
        filteredEnrollments = enrollments.where((enrollment) {
          return enrollment['userName']!.toLowerCase().contains(query.toLowerCase()) ||
                 enrollment['courseTitle']!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("User Enrollment Details", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
      //   backgroundColor: appBarColor,
      //   centerTitle: true,
      // ),
      appBar: CustomAppBar(title: 'User Enrollment Details', backgroundColor: appBarColor, titleColor: appColorblack),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search by name or course",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: filterEnrollments,
            ),
          ),
          Expanded(
            child: filteredEnrollments.isEmpty
                ? Center(
                    child: Text(
                      "No enrollments found",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: filteredEnrollments.length,
                      itemBuilder: (context, index) {
                        var enrollment = filteredEnrollments[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Card(
                            color: Colors.blueGrey.shade100,
                            elevation: 10,
                            
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              contentPadding: EdgeInsets.only(left: 15,top: 5,bottom: 5),
                              title: Text(
                                enrollment['userName'] ?? "Unknown User",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Text(
                                enrollment['courseTitle'] ?? "Unknown Course",
                                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                              ),
                              
                            ),
                          
                          ),
                        );
                      
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void fetchEnrollments() async {
    await Hive.openBox('adminEnrollments');
    var adminBox = Hive.box('adminEnrollments');
    var storedData = adminBox.get('enrollments', defaultValue: []);

    if (storedData is List) {
      try {
        setState(() {
          enrollments = storedData.map((e) => Map<String, String>.from(e)).toList();
          filteredEnrollments = enrollments;
        });
      } catch (e) {
        setState(() {
          enrollments = [];
          filteredEnrollments = [];
        });
      }
    } else {
      setState(() {
        enrollments = [];
        filteredEnrollments = [];
      });
    }
  }
}


