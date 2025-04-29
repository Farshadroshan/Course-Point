// import 'package:coursepoint/Screens/admin/admin_home.dart';
import 'package:coursepoint/Screens/admin/admin_screens/admin_home.dart';
import 'package:coursepoint/Screens/user/user_login.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/textFormFiled.dart';
import 'package:flutter/material.dart';

class AdminloginScreen extends StatefulWidget {
  const AdminloginScreen({super.key});

  @override
  State<AdminloginScreen> createState() => _AdminloginScreenState();
}

class _AdminloginScreenState extends State<AdminloginScreen> {
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (ctx) => const UserloginScreen()),
                    (route) => false);
              },
              icon:  Icon(
                Icons.supervised_user_circle_rounded,
                size: 30,
                color: appColorblack
              ),
            ),
          ),
        ],
      ),
      backgroundColor: appBarColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
        child: Container(
          height: 750,
          decoration: const BoxDecoration(
              color: Color(0xFF191919),
              borderRadius: BorderRadius.only(topRight: Radius.circular(200))),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      "Admin Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
                    child: Column(
                      children: [
                        TextFomfieldCustom(
                            controller: _usernameController,
                            labelText: 'User Name',
                            cursorColor: Color(0xFF909090),
                            prefixIcon: Icon(Icons.person,color: Color(0xFF909090),),
                            textColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Username';
                              }else{ 
                                return null;
                              }
                            },
                            bordercolor: Colors.grey),
                            SizedBox(height: 20,),
                        TextFomfieldCustom(
                            isPassword: true,
                            controller: _passwordController,
                            labelText: 'Password',
                            cursorColor: Colors.grey,
                            prefixIcon: Icon(Icons.lock,color: Color(0xFF909090),),
                            textColor: Colors.white,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Enter the password';
                              }else{
                                return null;
                              }
                            },
                            bordercolor: Colors.grey,
                            )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 35,
                  ),

                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        checkLogin(context);
                      } else {
                        print('Data is Empty');
                      }
                 
                    },
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            color: appBarColor,
                            borderRadius: BorderRadius.circular(5)),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(color: appColorblack),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkLogin(BuildContext ctx) async {
    const String correctUsername = 'admin';
    const String correctPassword = '123';

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username == correctUsername && password == correctPassword) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => AdminhomeScreen()),(route)=>false
      );
    _usernameController.clear();
    _passwordController.clear();
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          backgroundColor: Colors.grey,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          content: Text(
            'Username Password doesenot match',
            style: TextStyle(color: Colors.black),
          )));
    }

    
  }
}
