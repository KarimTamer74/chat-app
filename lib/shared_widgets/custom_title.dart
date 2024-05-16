import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
 const TitleWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text( title,
      // ignore: prefer_const_constructors
      style: TextStyle(fontSize: 21, color: Colors.white),
    );
  }
}
