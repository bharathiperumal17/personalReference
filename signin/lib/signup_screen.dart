import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:signin/functions.dart';
import 'package:signin/login_screen.dart';
import 'package:signin/otp.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
 final TextEditingController _usernamecontroller=TextEditingController();
final TextEditingController _password=TextEditingController();
 late String phonenumber;
 bool _obscureText=false;
final FocusNode _focusNode =FocusNode();

  @override
  Widget build(BuildContext context) {
    final firebaseprovider=context.read<FireBaseFunctions>();
    return  Scaffold(
      appBar: AppBar(
        title:const Text('signUp'),
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

              IntlPhoneField(
              cursorColor: Colors.grey,
              dropdownTextStyle: const TextStyle(color: Colors.black),
              pickerDialogStyle:PickerDialogStyle(
                searchFieldCursorColor: Colors.black,
                searchFieldInputDecoration: const InputDecoration(
                  
                  focusColor: Color.fromARGB(255, 39, 121, 176),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 39, 121, 176)
                    )
                  ),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 39, 121, 176))
                )
              ) ,
              focusNode: _focusNode,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.white54
                  )
                ),
                labelText: 'Phone Number',
                labelStyle: const TextStyle(color: Colors.white38),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white54
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                phonenumber=phone.completeNumber;
              },
            ),
      
           
           
             const Spacer(flex: 1,),
            ElevatedButton(onPressed: ()async{
              bool stored=await firebaseprovider.signin(_usernamecontroller.text.trim(), _password.text.trim(), phonenumber, context);
              if(stored){
                Navigator.push(context,MaterialPageRoute(builder: (context) => OtpScreen(phonenumber:phonenumber,),));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('something went wrong')));
              }
                   
              
            }, child: const Text('signup')),
            TextButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen(),));}, child:const Text('Already have an account')),
             const Spacer(flex: 3,),

             
          ],
        ),
      ),
    );
  }
}



