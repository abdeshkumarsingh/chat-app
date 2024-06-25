import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:messanger/components/rounded_button.dart';
import 'package:messanger/constants.dart';
import 'package:messanger/screens/chat_screen.dart';
import 'package:messanger/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  void initState(){
    Firebase.initializeApp();
  }
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
              Flexible (child :Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: kTextFieldInputDecoration.copyWith(hintText: 'Enter your Email'),
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
                name: 'Register',
                color: Colors.blueAccent,
                onclick: () async{
                  // Navigate from Here
                  setState(() {
                    _loading = true;
                  });
                  try{
                    final createUser = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
                    if(createUser != null){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('User Registered Sucessfully 😊'),
                        backgroundColor: Colors.green,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                      ),);
                      Future.delayed(Duration(seconds: 5));
                      Navigator.pushReplacementNamed(context, ChatScreen.id);
                      setState(() {
                        _loading=false;
                      });
                    }
                  } catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Registration Failed! Try Again! 😁'),
                      backgroundColor: Colors.redAccent,
                      elevation: 10,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(5),
                    ),);
                    print(e);
                    setState(() {
                      _loading = false;
                    });
                  }

                },
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Login here',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, LoginScreen.id);
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
