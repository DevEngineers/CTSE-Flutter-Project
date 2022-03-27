import 'package:flutter/material.dart';
import 'custom_text.dart';

class RadioButton extends StatelessWidget {
  final String answer;
  final String groupValue;
  final Function onChange;
  final bool isSelected;
  final bool? isSubmitted;
  const RadioButton(
      {Key? key,
      required this.answer,
      required this.groupValue,
      required this.onChange,
      required this.isSelected,
      this.isSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 65,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: isSelected ? const Color(0xffE78230) : const Color(0xffE0E2E4),
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              enabled: !isSubmitted!,
              onTap: () {
                onChange(answer);
              },
              title: CustomText(
                text: answer,
                color: 'black',
                fontWeight: FontWeight.bold,
              ),
              leading: Radio(
                activeColor: Colors.black54,
                value: answer,
                groupValue: groupValue,
                onChanged: (String? value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
