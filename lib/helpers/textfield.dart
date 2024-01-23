  import 'package:flutter/material.dart';

TextFormField textFormField({TextEditingController? controller,String? text,IconData? icon}) {
    return TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: text,
            
            hintStyle: TextStyle(color: Color.fromARGB(255, 98, 98, 98)),
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              
              borderRadius: BorderRadius.circular(10),
            )
          ),
        );
  }