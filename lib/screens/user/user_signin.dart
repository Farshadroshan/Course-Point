// import 'package:coursepoint/DataBase/Model/data_model.dart';
import 'dart:developer';

import 'package:coursepoint/DataBase/Functions/create_Id.dart';
import 'package:coursepoint/Screens/user/user_home.dart';
import 'package:coursepoint/Screens/user/user_login.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/textFormFiled.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UsersigninScreen extends StatefulWidget {
  const UsersigninScreen({super.key});

  @override
  State<UsersigninScreen> createState() => _UsersigninScreenState();
}

class _UsersigninScreenState extends State<UsersigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController =TextEditingController();
  final nameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        
      ),
      body:  Padding(
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
                        "Create Account",
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
                          TextFomfieldCustom(
                            controller: nameController,
                            labelText: 'Name',
                            cursorColor: Colors.grey,
                            prefixIcon: Icon(Icons.person,color: Colors.grey,),
                            textColor: Colors.white,
                            validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Enter Your Name';
                                }else if(value.trim().isEmpty){
                                  return 'Enter you Valid Name';
                                }else{
                                  null;
                                }return null;   
                            },
                                bordercolor: Colors.grey                               
                         ),  

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
                              controller: _passwordController,
                              isPassword: true,
                              labelText: 'Password',
                              cursorColor: Colors.grey,
                              prefixIcon: Icon(Icons.lock,color: Color(0xFF909090),),
                              textColor: Colors.white,
                              bordercolor: Colors.grey,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Enter Your password';
                                }else if(value.trim().length<8){
                                  return 'Password must be at least 8 characters long';
                                }else{
                                  return null;
                                }
                              },
                              ),
                              SizedBox(height: 10,),
                              GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                            builder: (ctx) =>const UserloginScreen()),(route)=>false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                            // decoration: BoxDecoration(color: Colors.teal),
                            child:const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Login Your Account",
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
                          createAccount();
                        }else{
                          print('Validation Faild');
                        }
                 //             Navigator.of(context).pushAndRemoveUntil(
                   // MaterialPageRoute(builder: (ctx) => const UserhomeScreen()),
                  // (route) => false);
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
                                "Create",
                                style: TextStyle(color: appColorblack,),
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
          
        // ),
      ),
      
    );
  }
  Future <void> createAccount()async{

      final userBox = Hive.box<UserLoginModel>('userBox');

      final existingUser = userBox.values.cast<UserLoginModel?>().firstWhere(
        (user) => user?.email == _emailController.text,
        orElse: () => null ,
        );

      if(existingUser != null ){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email alredy exists! Please use a different email.'), backgroundColor: Colors.red,)
        );
        return;
      }


      final id = createCustomId();

      final userData = UserLoginModel(
        name: nameController.text,
        password: _passwordController.text,
        email: _emailController.text,
        id: id,
        );

        await userBox.put(id,userData);

        final savedUser = userBox.get(id);
        if(savedUser == null){
          log('Error : user data not saved! ');
          return ;
        }
        
        log('User Created: ${savedUser.email}');
        log('User ID: $id');

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx)=> UserhomeScreen(userLogindata: savedUser,)), 
          (route)=>false);
        _passwordController.clear();
        _emailController.clear();
        nameController.clear();
  }
  
}
