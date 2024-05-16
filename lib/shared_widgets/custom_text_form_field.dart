import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {super.key, required this.hint, this.onChanged, this.obscureText});
  String? hint;
  Function(String)? onChanged;
  bool? obscureText;
  bool isEnabled = false;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  //عشان اخفي الباسورد لما يكتب
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        obscureText: widget.obscureText!,

        // obscuringCharacter:'*' <<<< لو عايز اعدل الشكل بتاع اخفاء الباس

        // عشان اخلي الايميل والباسورد مطلوبين
        validator: (value) {
          if ((value == null || value.isEmpty)) {
            return 'This field is required.';
          }

          return null; // Return null if the input is valid
        },
        onChanged: widget.onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            suffixIconColor: Colors.white54,
            suffixIcon: IconButton(
              icon: Icon(
                // عشان لو اليوزر حابب يخفي او يظهر اللي بيكتبه
                widget.obscureText! ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  widget.obscureText =
                      !widget.obscureText!; // Toggle the visibility
                });
              },
            ),
            enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            border: const OutlineInputBorder(),
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Colors.white38, fontSize: 14)),
      ),
    );
  }
}
