import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final Function(String v) onChanged;
  final String hint;
  const Input({Key? key, required this.controller, this.hint = "", required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (v){
        onChanged(v);
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-z_]")),
      ],
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: hint,
          fillColor: Colors.white70),
    );
  }
}
