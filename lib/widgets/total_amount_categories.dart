import 'package:flutter/material.dart';

class TotalCashCategory extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  TotalCashCategory({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,style: TextStyle(color: Colors.white),),
      trailing: Switch(
        focusColor: Colors.orange,
        value: value,
        onChanged: onChanged
      ),
    );
  }
}