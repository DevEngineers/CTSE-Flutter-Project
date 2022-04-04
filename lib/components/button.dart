import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final GestureTapCallback onPress;
  final double? width;
  final Color? color;

  const Button(
      {Key? key,
      required this.title,
      required this.onPress,
      this.width,
      this.color})
      : super(key: key);

  Size getButtonSize() {
    if (width != null) {
      return Size(width!, double.infinity);
    } else {
      return const Size(double.maxFinite, 50);
    }
  }

  Color? getButtonColor() {
    if (color != null) {
      return color;
    } else {
      return Colors.teal[400];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(title),
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          fixedSize: getButtonSize(),
          primary: getButtonColor(),
          textStyle: const TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}
