import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String? type;
  final String? color;

  const CustomText({Key? key, required this.text, this.type, this.color})
      : super(key: key);

  double getTextType() {
    switch (type) {
      case 'title':
        {
          return 26;
        }
      case 'headText':
        {
          return 22;
        }
      case 'bodyText':
        {
          return 20;
        }
      case 'bodyTextTwo':
        {
          return 18;
        }
      case 'label':
        {
          return 16;
        }
      default:
        {
          return 14;
        }
    }
  }

  Color? getTextColor() {
    if (color == 'white') {
      return Colors.white;
    } else if (color == 'gray') {
      return Colors.grey;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: getTextType(), color: getTextColor()));
  }
}
