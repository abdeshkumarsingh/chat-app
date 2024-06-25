import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messanger/screens/chat_screen.dart';
import 'package:messanger/screens/welcome_screen.dart';


class Authstream extends StatelessWidget {
  const Authstream({super.key});

  static String id = 'auth_stream';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Text('Something went wrong');
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        } else {
          if(snapshot.hasData){
            return ChatScreen();
          } else {
            return WelcomeScreen();
          }
        }
      },
    ),
    );
  }
}
