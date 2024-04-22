import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        label: Text('Username'),
                      )),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Get OTP'),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: TextField(
                    controller: _otpController,
                    decoration: const InputDecoration(labelText: 'OTP'),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Verify OTP'),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.65,
              child: TextField(
                controller: _newPasswordController,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.65,
              child: TextField(
                controller: _confirmPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
            ),
           const Spacer(),

            ElevatedButton(
              onPressed: () {},
              child: const Text('Reset Password'),
            ),
             const Spacer(flex: 6,),
          ],
        ),
      ),
    );
  }
}
