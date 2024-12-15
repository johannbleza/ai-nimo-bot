import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  List chatHistory = [
    "You are AI-NIMO an AI Companion in De La Salle University-Dasmarinas DLSU-D. "
  ];
  final _user = const types.User(
    id: 'user',
  );
  final _gemini =
      const types.User(id: 'gemini', imageUrl: 'assets/chat_profile.png');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Ai-nimo Lasalle",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Homestead', fontSize: 24)),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.restart_alt, color: Colors.white),
              onPressed: () {
                setState(() {
                  _messages.clear();
                  chatHistory.clear();
                  chatHistory = [
                    "You are AI-NIMO an AI Companion in De La Salle University-Dasmarinas DLSU-D. "
                  ];
                });
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            // color: Color(0xFF161616),
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Chat(
            showUserAvatars: true,
            theme: const DarkChatTheme(
                backgroundColor: Colors.transparent,
                secondaryColor: Colors.black,
                primaryColor: Color(0xFF00523E),
                inputTextCursorColor: Color(0xFF00523E),
                // sentMessageBodyTextStyle: TextStyle(color: Colors.black),
                inputBackgroundColor: Colors.black),
            useTopSafeAreaInset: true,
            messages: _messages,
            onSendPressed: _handleSendPressed,
            user: _user,
            emptyState: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 280,
                    child: Image.asset('assets/empty_state.png'),
                  ),
                  const SizedBox(
                    child: Text("Ask AI-NIMO anything!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    callGeminiModel(textMessage.text);
  }

  void callGeminiModel(String message) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: "AIzaSyCCEDPUYX2IOypf2d6VeVMUgr1ZAkVmypA",
    );

    final content = [
      Content.text(chatHistory.toString().replaceAll(RegExp(r'[\[\]]'), '') +
          message.toString())
    ];
    final response = await model.generateContent(content);

    final textMessage = types.TextMessage(
      author: _gemini,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: response.text.toString().trim(),
    );

    chatHistory.add(textMessage.text);
    _addMessage(textMessage);
  }
}
