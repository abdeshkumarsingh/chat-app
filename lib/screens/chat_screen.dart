import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messanger/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messanger/components/messageStreamBuilder.dart';
import 'package:messanger/screens/welcome_screen.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
 final FirebaseAuth _auth = FirebaseAuth.instance;
 final messageTextController = TextEditingController();
 late User? logged;
 late String text;
 final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
 final Stream<QuerySnapshot> _messagesStream = FirebaseFirestore.instance.collection('messages').snapshots(includeMetadataChanges: true);
 @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

 void getCurrentUser() async{
   try {
     final User? user = _auth.currentUser; // Use the correct method to get the current user
     if (user != null) {
       logged = user;// Use the null check operator to access the email property
     }
   } catch (e) {
     print(e);
   }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                //Implement logout functionality
                await _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: MessageStreamBuilder(currentUser: logged?.email,),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, right: 10, left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        text = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.white30),),
                    onPressed: () {
                      if(messageTextController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter a Message')));
                        return;
                      } else {
                        _fireStore.collection('messages').add({
                          'user' : logged?.email,
                          'text' : text,
                          'timestamp' : FieldValue.serverTimestamp(),
                        });
                        messageTextController.clear();
                      }
                      //Implement send functionality.

                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}






