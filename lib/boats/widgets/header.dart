import 'package:flutter/material.dart';

class HeaderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Boats",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.search,
            size: 30.0,
          )
        ],
      ),
    );
  }
}
