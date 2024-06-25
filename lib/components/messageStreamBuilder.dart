import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messanger/components/messageBox.dart';

class MessageStreamBuilder extends StatelessWidget {
  MessageStreamBuilder({required this.currentUser});

  String? currentUser;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView(
          reverse: true,
          children:
          snapshot.data!.docs.reversed.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            bool isUser;
            if(data['user'] == currentUser){
              isUser = true;
            } else {
              isUser = false;
            }
            return MessageBox(text: data['text'], user: data['user'], isUser: isUser,);
          }).toList(),
        );
      },
    );
  }
}