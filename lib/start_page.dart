import 'package:chat_bot/chat_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 320,
                child: Image.asset('assets/start_page.png'),
              ),
              const Text("AI-NIMO Lasalle",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Homestead',
                      fontSize: 40)),
              const SizedBox(
                width: 300,
                child: Text(
                    "Meet AI-NIMO, your friendly AI companion in DLSU-D.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white60,
                        fontFamily: 'Homestead',
                        fontSize: 16)),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 64,
                width: 160,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(Color(0xFF00523E))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatPage()),
                      );
                    },
                    child: const Text(
                      "Start Chat",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Homestead',
                          fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
