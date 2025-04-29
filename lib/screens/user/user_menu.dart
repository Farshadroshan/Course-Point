
import 'dart:typed_data';
import 'package:coursepoint/Screens/user/enrolled_course.dart';
import 'package:coursepoint/Screens/user/user_favorites.dart';
import 'package:coursepoint/Screens/user/user_login.dart';
import 'package:coursepoint/Screens/user/user_progress.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
import 'package:coursepoint/screens/user/user_settings.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UsermenuScreen extends StatefulWidget {
  const UsermenuScreen({super.key, required this.userLoginId});

  final UserLoginModel userLoginId;

  @override
  State<UsermenuScreen> createState() => _UsermenuScreenState();
}

class _UsermenuScreenState extends State<UsermenuScreen> {
  Uint8List? _imageBytes;
  late Box _userBox;

  @override
  void initState() {
    super.initState();
    openHiveBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Accounts', backgroundColor: appBarColor, titleColor: appColorblack),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: SizedBox(
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: _imageBytes != null
                              ? MemoryImage(_imageBytes!)
                              : const AssetImage("assets/Avatar.png") as ImageProvider,
                        ),
                        const Text('Edit photo', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        widget.userLoginId.name,
                        style: TextStyle(color: appColorblack, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey),
                  _buildMenuItem("Enrolled Courses", Icons.school, () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => EnrolledcourseScreen(userData: widget.userLoginId)));
                  }),
                  _buildMenuItem("Favorites", Icons.favorite_border, () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => UserfavoritesScreen(userData: widget.userLoginId)));
                  }),
                  _buildMenuItem("Progress", Icons.bar_chart, () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => UserprogressScreen(currentUserId: widget.userLoginId.id!)));
                  }),
                  _buildMenuItem("Settings", Icons.settings, () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => UsersettingsScreen()));
                  }),
                  _buildMenuItem("Logout", Icons.logout, _showLogoutDialog),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Picks an image from the gallery and stores it in Hive.
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = imageBytes;
      });
      _userBox.put(widget.userLoginId.id, imageBytes);
    }
  }

  /// Opens the Hive box and retrieves stored image data.
  Future<void> openHiveBox() async {
    _userBox = Hive.box('user_images');
    var storedBytes = _userBox.get(widget.userLoginId.id);
    if (storedBytes != null) {
      setState(() {
        _imageBytes = storedBytes;
      });
    }
  }

  /// Shows the logout confirmation dialog.
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const UserloginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  /// Helper method to build a menu item.
  Widget _buildMenuItem(String text, IconData icon, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 40,
            child: Row(
              children: [
                Icon(icon, color: appColorblack),
                const SizedBox(width: 25),
                Text(text, style: TextStyle(color: appColorblack, fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }
}

