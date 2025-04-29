import 'package:coursepoint/Screens/user/user_login.dart';
import 'package:coursepoint/widget/apppcolor.dart';

import 'package:flutter/material.dart';

class GetstartScreen extends StatelessWidget {
  const GetstartScreen({super.key});

  @override
  
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: appBarColor,
      body:SingleChildScrollView(
        child: Container(
            child: 
               Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Container(
                     
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/image.png',width: 500,height: 400,),
                            const SizedBox(height: 50,),
          
                            Text("Dive into a World of \nDiscovery",style: TextStyle(color: appColorblack,fontSize: 32,fontWeight: FontWeight.w900),),
                            const SizedBox(height: 5,),
                            Text("Unlock your potential with our interactive assignments designed to expand your horizons and ignite your curiosity. Explore new ideas, challenge yourself, and grow every day!",style: TextStyle(fontSize: 16,color: appColorblack),),
                              SizedBox(height: mediaQuery.size.height * 0.1,),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>const UserloginScreen()),(route)=>false);
                              },
                              child: Center(
                                child: Container(
                                  width:250,
                                  height: 60,
                                  decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(15)),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Get Started',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                                    ],
                                  )
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                     ),
                    ),
                   
                 ],
               ), 
          ),
      ),
      
    );
  }
}