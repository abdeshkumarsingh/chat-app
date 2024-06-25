import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messanger/screens/login_screen.dart';
import 'package:messanger/screens/registration_screen.dart';
import 'package:messanger/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {

  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  AnimationController? animationController;
  late Animation animation;
  final _auth = FirebaseAuth.instance;
  late bool isLogged;

  void chkLogin(){
    _auth.authStateChanges().listen((event) {
      if(event != null && mounted){
        setState(() {
          isLogged = true;
        });
      }
    },);
  }

  @override
  void initState(){
    chkLogin();
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
    animationController = AnimationController(
      duration: Duration(seconds: 2),
        vsync: this,
    );
    animation = ColorTween(begin: Colors.black12, end: Colors.white).animate(animationController!);
    animationController?.forward();
    animationController?.addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 60,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                Text(
                  'Flash chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.lightBlueAccent
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(color: Colors.cyanAccent, name: 'Login', onclick: () {
              //Go to login screen.
              Navigator.pushNamed(context, LoginScreen.id);
            },),
            RoundedButton(onclick: () {
//Go to registration screen.
              Navigator.pushNamed(context, RegistrationScreen.id);
            }, name: 'Register', color: Colors.blueAccent)
          ],
        ),
      ),
    );
  }
}
