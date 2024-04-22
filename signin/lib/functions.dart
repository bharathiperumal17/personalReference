// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin/login_screen.dart';

class FireBaseFunctions extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _verificationId = "";
  String _username = '';
  String _password = '';
  String _mobilenumber = '';

  signin(String username, String password, String mobilenumber,
      BuildContext context) async {
    try {
      DocumentSnapshot document =
          await _firestore.collection('users').doc(username).get();

      if (document.exists) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        if (data['username'] == username) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(' Alert'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Username is already exist'),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('ok'),
                  ),
                ],
              ),
            ),
          );
          notifyListeners();
          return;
        }
      }

      if (username == "" || password == "" || mobilenumber == "") {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Mandatory Alert'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Fill all the fields'),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('ok'),
                ),
              ],
            ),
          ),
        );

        notifyListeners();
        return false;
      } else {
        await sendOtp(context); // Send OTP first
        _username = username;
        _password = password;
        _mobilenumber = mobilenumber;
        notifyListeners();
        return true;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      notifyListeners();
      return false;
    }
  }

  Future<List> login(
      String username, String password, BuildContext context) async {
    try {
      if (username == '' || password == '') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Mandatory Alert'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Fill all the fields'),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('ok'))
              ],
            ),
          ),
        );
        notifyListeners();
        return [false, 'Enter the fields properly'];
      } else {
        // CollectionReference users=_firestore.collection('users');
        DocumentSnapshot document =
            await _firestore.collection('users').doc(username).get();

        if (document.exists) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          if (data['username'] != username) {
            notifyListeners();
            return [false, 'username is invalid'];
          } else if (data['password'] != password) {
            notifyListeners();
            return [false, 'password is invalid'];
          } else {
            notifyListeners();
            return [true, 'Login Successfully'];
          }
        } else {
          notifyListeners();
          return [false, 'username invalid'];
        }
      }
    } catch (e) {
      notifyListeners();
      return [false, e.toString()];
    }
  }

  Future<void> sendOtp(BuildContext context,) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: _mobilenumber,
          verificationCompleted: (PhoneAuthCredential credential) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("otp send successfully")));
          },
          verificationFailed: (FirebaseAuthException exception) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(exception.toString())));
          },
          codeSent: (String verificationId, int? resendToken) {
            _verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          timeout: const Duration(seconds: 60));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    notifyListeners();
  }

  Future<void> verifyOtp(BuildContext context, String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: otp);
      await _firebaseAuth.signInWithCredential(credential);

      // Verification successful, store data in Firestore
      await _firestore.collection('users').doc(_username).set({
        'username': _username,
        'password': _password,
        'phonenumber': _mobilenumber,
      });

      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('OTP verified successfully')));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    notifyListeners();
  }
    Future<void> updatePassword(String username, String newPassword, BuildContext context) async {
    try {
      // Check if the username exists
      DocumentSnapshot document = await _firestore.collection('users').doc(username).get();
      if (document.exists) {
        // Update the password field for the user document
        await _firestore.collection('users').doc(username).update({
          'password': newPassword,
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password updated successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Username not found')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update password: $e')));
    }
    notifyListeners();
  }


}
 


