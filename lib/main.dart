// import 'package:coursepoint/DataBase/Model/data_model.dart';
import 'package:coursepoint/DataBase/Model/courses_model.dart';
import 'package:coursepoint/DataBase/Model/note_model.dart';
import 'package:coursepoint/DataBase/Model/playlist_model.dart';
import 'package:coursepoint/DataBase/Model/subcourse_model.dart';
import 'package:coursepoint/Logo.dart';
import 'package:coursepoint/database/model/admin_model.dart';
import 'package:coursepoint/database/model/chat_message.dart';
import 'package:coursepoint/database/model/progress_model.dart';
import 'package:coursepoint/database/model/user_details_model.dart';
import 'package:coursepoint/database/model/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future <void> main() async{
 await Hive.initFlutter();
 if(!Hive.isAdapterRegistered(UserLoginModelAdapter().typeId)){
  Hive.registerAdapter(UserLoginModelAdapter());
 }

// if(!Hive.isAdapterRegistered(CoursesModelAdapter().typeId)){
//   Hive.registerAdapter(CoursesModelAdapter());
// }
if(!Hive.isAdapterRegistered(CoursesModelAdapter().typeId)){
  Hive.registerAdapter(CoursesModelAdapter());
}


 if (!Hive.isAdapterRegistered(SubcourseModelAdapter().typeId)){
  Hive.registerAdapter(SubcourseModelAdapter());
 }

if(!Hive.isAdapterRegistered(PlaylistModelAdapter().typeId)){
  Hive.registerAdapter(PlaylistModelAdapter());
}

if(!Hive.isAdapterRegistered(NoteModelAdapter().typeId)){
  Hive.registerAdapter(NoteModelAdapter());
}

if(!Hive.isAdapterRegistered(UserDetailsModelAdapter().typeId)){
  Hive.registerAdapter(UserDetailsModelAdapter());
}
if(!Hive.isAdapterRegistered(ProgressModelAdapter().typeId)){
  Hive.registerAdapter(ProgressModelAdapter());
}
if(!Hive.isAdapterRegistered(AdminModelAdapter().typeId)){
  Hive.registerAdapter(AdminModelAdapter());
}
if(!Hive.isAdapterRegistered(ChatMessageAdapter().typeId)){
  Hive.registerAdapter(ChatMessageAdapter());
}
  // print("ProgressModelAdapter Registered: ${Hive.isAdapterRegistered(1)}");  

await Hive.openBox('adminEnrollments');
await Hive.openBox<ProgressModel>('progressBox');
// await Hive.openBox<ProgressModel>('progress');
await Hive.openBox<AdminModel>('adminBox'); // Open the box
await Hive.openBox<UserLoginModel>('userBox');
await Hive.openBox('favorites');
await Hive.openBox('userEnrollments');
//  Hive.openBox('settingsBox');
 await Hive.openBox('user_images');
 await Hive.openBox('chats');
await dotenv.load(fileName: 'assets/.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: 
      const LogoScreen()
     // AdminloginScreen()
    );
  }
}
