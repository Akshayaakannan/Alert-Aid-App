import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'messages.dart';
import 'package:disaster_management/components/custom_bottom_navbar.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  _AiAssistanceScreenState createState() => _AiAssistanceScreenState();
}

class _AiAssistanceScreenState extends State<AssistantScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    dialogFlowtter = DialogFlowtter();
  }

  void sendMessage(String text) async {
    if (text.isEmpty) return;

    setState(() {
      addMessage(Message(text: DialogText(text: [text])), true);
    });

    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: text)),
    );

    if (response.message == null) return;

    setState(() {
      addMessage(response.message!);
    });

    Future.delayed(Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }

  Widget buildInfoCard(String text, {Color color = Colors.white}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildInfoCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildInfoCard(
          "💬 Things you can ask me:",
          color: const Color.fromARGB(255, 230, 236, 239),
        ),
        buildInfoCard(
          "• What to do during a flood?",
          color: const Color.fromARGB(255, 230, 236, 239),
        ),
        buildInfoCard(
          "• Emergency contacts in Sri Lanka?",
          color: const Color.fromARGB(255, 230, 236, 239),
        ),
        buildInfoCard(
          "• How to prepare a disaster kit?",
          color: const Color.fromARGB(255, 230, 236, 239),
        ),
        buildInfoCard(
          "• Cyclone safety precautions?",
          color: const Color.fromARGB(255, 230, 236, 239),
        ),
        buildInfoCard(
          "• First aid tips after a landslide?",
          color: const Color.fromARGB(255, 230, 236, 239),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ai Assistant',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (messages.isEmpty)
              Expanded(
                child: Center(
                  child: SingleChildScrollView(child: buildInfoCardsSection()),
                ),
              )
            else
              Expanded(
                child: MessagesScreen(
                  messages: messages,
                  controller: _scrollController,
                ),
              ),
            // Input Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: Icon(Icons.send, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 0,
        onItemTapped: (index) {
          if (index == 1) return;

          String route = '';
          switch (index) {
            case 0:
              route = '/home';
              break;
            case 1:
              route = '/emergencyAlerts';
              break;
            case 2:
              route = '/newsfeed';
              break;
            case 3:
              route = '/profile';
              break;
          }

          if (route.isNotEmpty) {
            Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
          }
        },
      ),
    );
  }
}
