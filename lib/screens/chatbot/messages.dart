import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class MessagesScreen extends StatelessWidget {
  final List messages;
  final ScrollController controller;

  const MessagesScreen({
    super.key,
    required this.messages,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.builder(
      controller: controller,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index]['message'] as Message;
        final isUserMessage = messages[index]['isUserMessage'] as bool;

        if (message.text?.text == null || message.text!.text!.isEmpty) {
          return SizedBox.shrink(); // Skip if empty message
        }

        return Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment:
                isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(isUserMessage ? 0 : 20),
                    topLeft: Radius.circular(isUserMessage ? 20 : 0),
                  ),
                  color: isUserMessage
                      ? Colors.grey.shade300
                      : Colors.grey.shade300.withOpacity(0.8),
                ),
                constraints: BoxConstraints(maxWidth: w * 2 / 3),
                child: Text(
                  message.text!.text![0],
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
