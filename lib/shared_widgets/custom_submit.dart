import 'package:flutter/material.dart';

class CustomSubmit extends StatelessWidget {
  const CustomSubmit({super.key, required this.text, this.onTap});
  final String text;

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white60,
        ),
        margin: EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login_outlined),
            Text(
              text,
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 1, 46, 52)),
            ),
          ],
        ),
      ),
    );
  }
}
