import 'package:coursepoint/DataBase/Functions/database_functions.dart';
import 'package:coursepoint/Screens/user/get_start.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:flutter/material.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState(){
    super.initState();
    gotoGetStart();
  }

  @override
  Widget build(BuildContext context) {

    // fetchAllCourses();
    fechingCourseDetails();
    fechingSubCourseDetails();
    fechingPlayListDetails();
    fechingNoteDetails();
    
    return Scaffold(
      body: Container(
         color: const Color(0xFF191919),
         child: Center(
          child: Text.rich(TextSpan(text: 'Course',style: TextStyle( fontSize: 25 ,fontWeight: FontWeight.w900, color: appBarColor),
          children: const [TextSpan(text: 'point',style: TextStyle(color: Colors.white))]))
          
          // child: Image.asset('assets/logo-png.png',width: 200,height: 200,),
          
         ),
      )
    );
  }

  Future<void>gotoGetStart()async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const GetstartScreen()));
  }

}