import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:messanger/components/rounded_button.dart';
import 'package:messanger/constants.dart';
import 'package:messanger/screens/chat_screen.dart';
import 'package:messanger/screens/registration_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late String email;
  late String pass;
  late bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(child: Hero(
                tag: 'logo',
                child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
                ),
              )),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: kTextFieldInputDecoration.copyWith( hintText: 'Enter Your Email'),
                style: kTextfieldTextStyle,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  pass = value;
                },
                decoration: kTextFieldInputDecoration.copyWith(hintText: 'Enter Your Password'),
                style: kTextfieldTextStyle,
                obscureText: true,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                name: 'Login',
                color: Colors.cyanAccent,
                onclick: () async{
                  setState(() {
                    _loading = true;
                  });
                  // navigate from here
                  try{
                    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Hurry! Login Successful'),
                      backgroundColor: Colors.green,
                      elevation: 10,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(5),
                    ),);
                    Navigator.pushReplacementNamed(context, ChatScreen.id);
                    setState(() {
                      _loading = false;
                    });
                  } on FirebaseAuthException catch (e) {
                    print(e.code);
                    if(e.code == 'invalid-credential'){
                      setState(() {
                        _loading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Wrong Email or Password!'),
                        backgroundColor: Colors.redAccent,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                      ),);
                    }
                  }
                },
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Create here',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacementNamed(context, RegistrationScreen.id);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
