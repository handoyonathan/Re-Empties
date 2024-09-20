import 'package:flutter/material.dart';
import 'package:re_empties/constant/colors.dart';
import 'package:re_empties/widgets/button_main_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: CustomColor.yellow5, // Set background color to yellow5
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My First App',
                style: TextStyle(fontSize: 24),
              ),
              Text("test"),
              AppMainButton(state: ButtonState.cancel, text: "Cancel"),
              SizedBox(height: 20),
              AppMainButton(state: ButtonState.primary, text: "Register"),
            ],
          ),
        ),
      ),
    );
  }
}
