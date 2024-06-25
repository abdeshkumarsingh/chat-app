import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  MessageBox({required this.text, required this.user, required this.isUser});

  String text;
  String? user;
  bool isUser = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isUser) Padding(
                padding: const EdgeInsets.only(right: 8, left: 8, bottom: 15),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 23,
                  child: Icon(Icons.supervisor_account, color: Colors.white, size: 35,),
                ),
              ),
              Flexible(
                child: Material(
                  elevation: 5.0,
                  borderRadius: isUser ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ) : BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  color: isUser ? Colors.lightBlue : Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(text, style: TextStyle(color: isUser ? Colors.white : Colors.black),),
                  ),
                ),
              ),
              if (isUser) Padding(
                padding: const EdgeInsets.only(right: 8, left: 8, bottom: 15),
                child: CircleAvatar(
                  radius: 23,
                  child: Icon(Icons.person, color: Colors.white, size: 35,),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 4),
            child: Text(
              user!,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}