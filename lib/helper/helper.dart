import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: const Color.fromARGB(96, 158, 158, 158),
      content: Center(child: Text(message)),
    ),
  );
}
