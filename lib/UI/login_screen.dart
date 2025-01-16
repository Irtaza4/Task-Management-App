import 'package:final_project_internship/Services/auth_provider.dart';
import 'package:final_project_internship/UI/home_screen.dart';
import 'package:final_project_internship/UI/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return  Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              Text("Welcome back, you've been missed!",style: TextStyle(
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
              SizedBox(height: 30),
              ElevatedButton(onPressed: ()async{
                if(_globalKey.currentState!.validate()){
                  try{
                    await authProvider.signIn(emailController.text,
                        pwController.text);
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context)=>HomeScreen()));
                  }
                  catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Wrong email or password')),
                    );
                  }
                }


              }, child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(50, 50),
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an Account?",style: TextStyle(
                      color: Colors.grey.shade600,fontSize: 10),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context)=>SignupScreen()));
                  }, child: Text('SignUp!',style: TextStyle(
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
