import 'package:flutter/material.dart';
import 'package:TaskVault/util/my_button.dart';

class dialogbox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  dialogbox({
    super.key,
    this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 244, 244, 240),
      content: Container(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //user input field
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add new task"),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                MyButton(
                  text: "save",
                  onpressed: onSave,
                ),

                const SizedBox(
                  width: 4,
                ),

                //cancel button
                MyButton(text: "cancel", onpressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
