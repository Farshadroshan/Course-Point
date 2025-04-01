// import 'package:coursepoint/DataBase/Model/data_model.dart';
import 'dart:developer';

// import 'package:coursepoint/Screens/admin/admin_login.dart';
import 'package:coursepoint/Screens/admin/admin_screens/admin_login.dart';
import 'package:coursepoint/Screens/user/user_home.dart';
// import 'package:coursepoint/Screens/user/user_home.dart';
// import 'package:coursepoint/Screens/user/user_signin.dart';
import 'package:coursepoint/Screens/user/user_signin.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/textFormFiled.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserloginScreen extends StatefulWidget {
  const UserloginScreen({super.key});

  @override
  State<UserloginScreen> createState() => _UserloginScreenState();
}
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController =TextEditingController();

class _UserloginScreenState extends State<UserloginScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (ctx) => const AdminloginScreen()),
                    (route) => false);
              },
              icon:  Icon(
                Icons.admin_panel_settings,
                size: 30,
                color: appColorblack,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
        child: Container(
          // height: 750,
          height: MediaQuery.of(context).size.height,
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
                      "Login Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        
                        TextFomfieldCustom(
                          bordercolor: Colors.grey,
                          controller: _emailController,
                          cursorColor: Colors.grey,
                          labelText: 'Email Address',
                          prefixIcon: const Icon(Icons.email,color: Color(0xFF909090),),
                          textColor: Colors.white,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your Emal Address';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Enter a valid Email';
                            }else{
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFomfieldCustom(
                          isPassword: true,
                            controller: _passwordController,
                            labelText: 'Password',
                            cursorColor: Colors.grey,
                            prefixIcon: Icon(Icons.lock,color: Color(0xFF909090),),
                            textColor: Colors.white,
                            bordercolor: Colors.grey,
                            validator: (value){
                              if(value == null || value.isEmpty ){
                                return 'Enter Your password';
                              }else if(value.length<8){
                                return 'Invalid password';
                              }else{
                                return null;
                              }

                            },
                            ),
                            SizedBox(height: 10,),
                            GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                          builder: (ctx) =>const UsersigninScreen()),(route)=>false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                          // decoration: BoxDecoration(color: Colors.teal),
                          child:const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Create Account",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                    ),
                  ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  GestureDetector(
                    onTap: () {
                     if(_formKey.currentState!.validate()){
                      userLogin();
                     }else{
                      print('Validation Faild');
                     }
                    },
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            color: appBarColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
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

  Future<void> userLogin() async {
  final userBox = Hive.box<UserLoginModel>('userBox');
  final enteredEmail = _emailController.text;
  final enteredPassword = _passwordController.text;

  UserLoginModel? userData;
  
  // Find user by email
  for (var key in userBox.keys) {
    UserLoginModel? user = userBox.get(key);
    if (user?.email == enteredEmail) {
      userData = user;
      break;
    }
  }

  if (userData != null && userData.password == enteredPassword) {
    log('Login successful! User ID: ${userData.id}');
    

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (ctx) => UserhomeScreen(userLogindata: userData!,)),
      (route) => false,
    );
    _emailController.clear();
    _passwordController.clear(); 
    

  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invalid Email or Password')),
    );
  }
}

  
}
