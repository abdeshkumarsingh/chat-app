import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messanger/screens/welcome_screen.dart';
import 'package:messanger/screens/login_screen.dart';
import 'package:messanger/screens/registration_screen.dart';
import 'package:messanger/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messanger/components/authStream.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatefulWidget {
  const FlashChat({super.key});

  static String id = 'flash_chat';

  @override
  State<FlashChat> createState() => _FlashChatState();
}

class _FlashChatState extends State<FlashChat> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.copyWith(
          bodySmall: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: Authstream.id,
      routes: {
        LoginScreen.id : (context) => LoginScreen(),
        WelcomeScreen.id : (context) => WelcomeScreen(),
        ChatScreen.id : (context) => ChatScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        FlashChat.id : (context) => FlashChat(),
        Authstream.id : (context) => Authstream(),
      },
    );
  }
}

