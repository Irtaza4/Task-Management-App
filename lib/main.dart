import 'package:final_project_internship/Services/add_task_provider.dart';
import 'package:final_project_internship/Services/auth_provider.dart';
import 'package:final_project_internship/Services/splash_screen_provider.dart';
import 'package:final_project_internship/UI/SplashScreen/splash_screen.dart';
import 'package:final_project_internship/UI/login_screen.dart';
import 'package:final_project_internship/UI/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_)=>SplashScreenProvider()),
        ChangeNotifierProvider(create: (_)=>AddTaskProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                centerTitle: true,
                color: Colors.deepPurple,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize:25
                ),
              iconTheme: IconThemeData(color: Colors.white)
            ),

        ),
        home:  SplashScreen(),
      ),
    );
  }
}
