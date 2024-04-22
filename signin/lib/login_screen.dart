// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signin/forgotpassword.dart';
import 'package:signin/functions.dart';
import 'package:signin/decoredui.dart';
import 'package:signin/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final TextEditingController _usernamecontroller=TextEditingController();
final TextEditingController _password=TextEditingController();
bool _obscureText=false;
  @override
  Widget build(BuildContext context) {
    final firebaseprovider=context.read<FireBaseFunctions>();
    return  Scaffold(
      appBar: AppBar(
        title:const Text('Login using Firebase'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _usernamecontroller,
                decoration: InputDecoration(
                  hintText: 'username',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                ),
              ),
            ),
            
           Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextFormField(
    obscureText: _obscureText,
    controller: _password,
    decoration: InputDecoration(
      hintText: 'password',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    ),
  ),
),
Align(
  alignment: Alignment.bottomRight,
  child: TextButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => const ForgotPassword(),)), child: Text('Forgot password',style: TextStyle(color: Colors.red),))),

             const Spacer(flex: 1,),
            ElevatedButton(onPressed: ()async{
              List present=await firebaseprovider.login(_usernamecontroller.text.trim(), _password.text.trim(),context);
              if(present[0]){
                Navigator.push(context,MaterialPageRoute(builder: (context) =>  UiOne(),));
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(present[1]),));
              }else{
              ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(present[1]),));
              }
             
            }, child: const Text('Login')),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>const SignupScreen(),));
            }, child:const Text("Don't have an account already")),
             const Spacer(flex: 3,),

             
          ],
        ),
      ),
    );
  }
}