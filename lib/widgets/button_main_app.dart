import 'package:flutter/material.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/widgets/alert_dialog.dart';

enum ButtonState { primary, cancel }

class AppMainButton extends StatelessWidget {
  final ButtonState state;
  final String text;
  final void Function() onPressed; // Callback function for different actions

  const AppMainButton({
    super.key,
    required this.state,
    required this.text,
    required this.onPressed, // Initialize onPressed as a required parameter
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = colors.bgColor;
    Color backgroundColor = colors.green2;

    if (state == ButtonState.primary) {
      backgroundColor = colors.green2;
    } else if (state == ButtonState.cancel) {
      backgroundColor = colors.red1;
    }

    // Get the screen width and calculate the button width to be responsive
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth - 40; // 20px margin on left and right

    return ElevatedButton(
      onPressed: onPressed, // Use the onPressed callback passed to the button
      style: ElevatedButton.styleFrom(
        minimumSize: Size(buttonWidth, 48), // Set button size
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Set corner radius to 15
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white, // Set text color to white
          fontSize: 20, // Set text size to 20
          fontWeight: FontWeight.w500, // Semi-bold text
        ),
      ),
    );
  }
}
