import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:signin/functions.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key, required this.phonenumber}) : super(key: key);

  final String phonenumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final List<TextEditingController> _otp;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _otp = List.generate(6, (index) => TextEditingController());
    _focusNode = FocusNode();
  }

  String _submitOtp() {
    String otpValue = _otp.map((controller) => controller.text).join('');
    return otpValue;
    // print('Entered OTP: $otp');
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _otpprovider=context.read<FireBaseFunctions>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enabled: false,
                controller: TextEditingController(text: widget.phonenumber),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone Number',
                ),
              ),
            ),
           ElevatedButton(
  onPressed: () async {
    await _otpprovider.sendOtp(context); 
  },
  child: const Text('Generate OTP'),
),


            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 40,
                    child: TextField(
                      controller: _otp[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        counterText: '',
                      ),
                    ),
                  ),
                )..add(const SizedBox(width: 16)),
              ),
            ),
           
            const Spacer(
              flex: 1,
            ),
            ElevatedButton(
              onPressed: () async{

            await  _otpprovider.verifyOtp(context, _submitOtp());
              },
              child: const Text('Login'),
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
