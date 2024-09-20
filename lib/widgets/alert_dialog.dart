import 'package:flutter/material.dart';
import 'package:re_empties/cores/constant/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: colors.bgColor,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            // Warning icon with circle background
            CircleAvatar(
              backgroundColor: colors.red1, // Circle background color
              radius: 35, // Adjust size as needed
              child: Icon(
                Icons.warning, // Warning icon
                color: Colors.white, // Icon color
                size: 45, // Icon size
              ),
            ),
            const SizedBox(height: 10), // Space between icon and text
            Text(
              'Cancel',
              style: TextStyle(
                color: colors.green1,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),

            Text(
              'Are you sure you want to cancel? \n This can\'t be undone.',
              style: TextStyle(
                color: colors.green1,
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Horizontal line
            // Horizontal line spanning the entire width
            const Divider(
              thickness: 1,
              color: Color(0xFFDADADA),
              height: 0, // Set height to 0 for perfect line fit
            ),
// Row with two buttons and a vertical divider
            Expanded(
              child: Row(
                children: [
                  // Back button
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog on back
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: colors.green1,
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontWeight: FontWeight.normal, // Regular text
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  // Vertical line between buttons
                  Container(
                    width: 1, // Set width for the vertical line
                    color: const Color(0xFFDADADA), // Line color
                  ),

                  // Cancel button
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        // Define the cancel action here
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: colors.red1,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Bold text
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
