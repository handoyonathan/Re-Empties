import 'package:flutter/material.dart';
import 'package:re_empties/constant/colors.dart';
import 'package:re_empties/widgets/alert_dialog.dart';

enum ButtonState { primary, cancel }

class AppMainButton extends StatelessWidget {
  final ButtonState state;
  final String text;

  const AppMainButton({
    super.key,
    required this.state,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = CustomColor.yellow5;
    Color backgroundColor = CustomColor.green2;

    if (state == ButtonState.primary) {
      backgroundColor = CustomColor.green2;
    } else if (state == ButtonState.cancel) {
      backgroundColor = CustomColor.red1;
    }

    // Get the screen width and calculate the button width to be responsive
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth - 40; // 20px margin on left and right

    return ElevatedButton(
      onPressed: () {
        if (state == ButtonState.cancel) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomAlertDialog();
            },
          );
        }
      }, // Define your button action here
      style: ElevatedButton.styleFrom(
        minimumSize: Size(buttonWidth, 48), // Set button size
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Set corner radius to 15
        ), // Set background color
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white, // Set text color to white
          fontSize: 20, // Set text size to 20
          fontWeight: FontWeight.w500, // Semi-bold text
        ), // Set text color
      ),
    );
  }
}
