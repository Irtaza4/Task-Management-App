import 'package:final_project_internship/Services/splash_screen_provider.dart';
import 'package:final_project_internship/UI/home_screen.dart';
import 'package:final_project_internship/UI/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool hasNavigated = false; // Ensure navigation occurs only once

    return Scaffold(
      body: Consumer<SplashScreenProvider>(
        builder: (context, value, _) {
          if (!value.isInitialized) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.task_alt,color: Colors.deepPurple,size: 70,),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Welcome To TaskMg",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            );
          }

          // Navigate to the appropriate screen once initialized
          if (!hasNavigated) {
            hasNavigated = true; // Prevent multiple navigations
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (value.user != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  LoginScreen()),
                );
              }
            });
          }

          return const SizedBox.shrink(); // Return an empty widget after navigation
        },
      ),
    );
  }
}
