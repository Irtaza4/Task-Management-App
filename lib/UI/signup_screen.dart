import 'package:final_project_internship/Services/auth_provider.dart';
import 'package:final_project_internship/UI/home_screen.dart';
import 'package:final_project_internship/UI/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});


  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController cpwController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return  Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Center(child: Icon(Icons.task_alt,color: Colors.deepPurple,size: 70,)),
              ),
              SizedBox(height: 30,),
              Text("Let's create an account for you",style: TextStyle(
                  color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15),),
              SizedBox(height: 30,),
              Text("Enter your email i.e. johndoe@gmail.com",style: TextStyle(
                  color: Colors.grey.shade600,fontWeight: FontWeight.bold,fontSize: 10),),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter email';
                    }
                    else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(

                      )
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text("Enter your password",style: TextStyle(
                  color: Colors.grey.shade600,fontWeight: FontWeight.bold,fontSize: 10),),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                  controller: pwController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter Password';
                    }
                    else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(

                      )
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text("Confirm your password",style: TextStyle(
                  color: Colors.grey.shade600,fontWeight: FontWeight.bold,fontSize: 10),),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                  controller: cpwController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value){
                    if( pwController.text!=cpwController.text ){
                      return "Passwords don't match";
                    }
                    else if( value!.isEmpty){
                      return "Enter confirm password";
                    }
                    else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(

                      )
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(onPressed: ()async{
                if(_globalKey.currentState!.validate()){
                  try{
                    await authProvider.signUp(emailController.text.trim(),
                        pwController.text.trim());
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context)=>HomeScreen()));
                  }
                  catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Wrong email or password')),
                    );
                  }
                }


              }, child: Text('Signup'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(50, 50),
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an Account?",style: TextStyle(
                      color: Colors.grey.shade600,fontSize: 10),),
                  TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context)=>LoginScreen()));
                  }, child: Text('LogIn!',style: TextStyle(
                      color: Colors.grey.shade600,fontWeight:FontWeight.bold
                      ,fontSize: 10)))
                ],
              ),


            ],
          ),
        ),
      ),

    );
  }
}
