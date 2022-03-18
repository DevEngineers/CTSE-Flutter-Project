import 'package:flutter/material.dart';
import 'custom_text.dart';

class RadioButton extends StatelessWidget {
  final String answer;
  final String groupValue;
  final Function onChange;
  const RadioButton(
      {Key? key,
      required this.answer,
      required this.groupValue,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 70,
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: CustomText(text: answer),
              leading: Radio(
                value: answer,
                groupValue: groupValue,
                onChanged: (String? value) {
                  onChange(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}