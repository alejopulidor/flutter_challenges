import 'package:flutter/material.dart';

class ByText extends StatelessWidget {
  final text;

  const ByText(
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black.withOpacity(0.6)),
        children: [
          TextSpan(text: "By "),
          TextSpan(text: text, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
