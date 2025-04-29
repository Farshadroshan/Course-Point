
import 'package:coursepoint/Screens/user/user_home.dart';
import 'package:coursepoint/screens/user/user_menu.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:flutter/material.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget{
  const UserAppBar({
    super.key,
    required this.widget,
  });

  final UserhomeScreen widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      
      
    );
  }

   @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}