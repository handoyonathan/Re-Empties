import 'package:flutter/material.dart';
import 'package:re_empties/constant/colors.dart';
import 'package:re_empties/widgets/alert_dialog.dart';
import 'package:re_empties/widgets/button_main_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.yellow5,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'My First App',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),

            // Cancel button with a dialog action
            AppMainButton(
              state: ButtonState.cancel,
              text: "Cancel",
              onPressed: () {
                showCancelDialog(context); // Pass context here correctly
              },
            ),
            const SizedBox(height: 20),

            // Register button with a print action
            AppMainButton(
              state: ButtonState.primary,
              text: "Register",
              onPressed: () {
                print("Register button pressed"); // Perform action for Register
              },
            ),

            // Order button with a print action
            const SizedBox(height: 20),
            AppMainButton(
              state: ButtonState.primary,
              text: "Order",
              onPressed: () {
                print("Order button pressed"); // Perform action for Order
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to show dialog for Cancel button
  static void showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlertDialog(); // Removed the const here
      },
    );
  }
}
