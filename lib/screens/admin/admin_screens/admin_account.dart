
import 'dart:io';
import 'package:coursepoint/Screens/user/user_login.dart';
import 'package:coursepoint/database/model/admin_model.dart';
import 'package:coursepoint/screens/admin/admin_screens/admin_user_enrollments.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/menuItems.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminAccountScreen extends StatefulWidget {
  const AdminAccountScreen({super.key});

  @override
  State<AdminAccountScreen> createState() => _AdminAccountScreenState();
}

class _AdminAccountScreenState extends State<AdminAccountScreen> {
  String userName = 'Admin';
  File? userImage;
  final TextEditingController nameController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadAdminData();
  }

  Future<void> loadAdminData() async {
    if (!Hive.isBoxOpen('adminBox')) {
      await Hive.openBox<AdminModel>('adminBox');
    }
    final box = Hive.box<AdminModel>('adminBox');
    final adminData = box.get('adminData');

    setState(() {
      if (adminData != null) {
        userName = adminData.name;
        userImage = adminData.image.isNotEmpty ? File(adminData.image) : null;
      }
    });
  }

  Future<void> saveData(String name) async {
    final box = Hive.box<AdminModel>('adminBox');
    final admin = AdminModel(
      image: userImage?.path ?? '',
      name: name,
    );
    await box.put('adminData', admin);
    setState(() {
      userName = name;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF191919),
      appBar: AppBar(
        // iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor:  appBarColor,
        centerTitle: true,
        title: const Text(
          'Account',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: userImage != null
                        ? FileImage(userImage!)
                        : const AssetImage('assets/Avatar.png') as ImageProvider,
                    radius: 50,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: showEditDialog,
                          icon: const Icon(Icons.edit, color: Colors.black),
                        ),
                      ],
                    ),
                  ),

                  
                ],
              ),

            ),
           

            const SizedBox(height: 20),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AdminEnrollmentsScreen()));
                  },
                  child: Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.note_alt_rounded, color: Colors.black),
                        Text("Enroll Details", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
               

                 GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text('Logout'),
                          content: const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: () async {
                                 
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              const UserloginScreen()),
                                      (route) => false);
                                },
                                child: const Text('Logout'))
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: appColorblack),
                         Text("Logout", style: TextStyle(color: appColorblack)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void showEditDialog() {
    nameController.text = userName;
    File? tempImage = userImage;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  final XFile? pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setDialogState(() {
                      tempImage = File(pickedFile.path);
                    });
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: tempImage != null
                      ? FileImage(tempImage!)
                      : const AssetImage('assets/Avatar.png') as ImageProvider,
                  radius: 45,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Name',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (tempImage != null) {
                  setState(() {
                    userImage = tempImage;
                  });
                }
                await saveData(nameController.text);
                Navigator.pop(context);
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> pickImage() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        userImage = File(pickedFile.path);
      });
    }
  }
}




