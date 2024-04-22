import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:signin/listpage.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return  LinearGradient(
                  colors: [ Colors.blueGrey, Colors.purple,Colors.purple.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Text(
                "What's your Mobile Number ? ",
                style:  TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black, 
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      blurRadius: 4,
                    )
                  ],
                ),
              ),
            ),
           
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text:
                      "To login to your account or register if you are new to ",
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 17),
                ),
                WidgetSpan(
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [Colors.white, Colors.blueGrey, Colors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: const Text(
                      'Musick',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white, 
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 4,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                WidgetSpan(
                    child: Image.asset(
                  'asset/image/2-2-musical-notes-png-picture-thumb.png',
                  height: 24,
                ))
              ])),
            ),
            IntlPhoneField(
              cursorColor: Colors.grey,
              dropdownTextStyle: const TextStyle(color: Colors.white),
              pickerDialogStyle: PickerDialogStyle(
                  searchFieldCursorColor: Colors.white,
                  searchFieldInputDecoration: const InputDecoration(
                      focusColor: Colors.purple,
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      labelStyle: TextStyle(color: Colors.purple))),
              focusNode: focusNode,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white54)),
                labelText: 'Phone Number',
                labelStyle: const TextStyle(color: Colors.white38),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white54),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                // print(phone.completeNumber);
              },
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Having problem or forget the number ? ',
                  style: TextStyle(
                      color: Colors.purple.shade400,
                      fontSize: 15,
                      fontStyle: FontStyle.italic)),
              WidgetSpan(
                  child: Image.asset(
                "asset/image/36853-3-hand-emoji-thumb.png",
                height: 26,
              )),
            ])),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    backgroundColor: MaterialStatePropertyAll(
                        Colors.purple.withOpacity(0.5)),
                    padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListPage(),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Next ',
                      style: TextStyle(
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                          fontSize: 22),
                    ),
                    Image.asset(
                     "asset/image/36853-3-hand-emoji-thumb.png" ,
                      height: 26,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 55,
            )
          ],
        ),
      ),
    );
  }
}
