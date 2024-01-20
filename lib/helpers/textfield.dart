  import 'package:flutter/material.dart';

TextFormField textFormField({TextEditingController? controller,String? text,IconData? icon}) {
    return TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
          ),
        );
  }