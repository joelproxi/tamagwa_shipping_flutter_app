import 'package:flutter/material.dart';

Widget dropdownField(BuildContext context, List<String> liste,
    void changeFunction(String _defaultValue)) {
  return DropdownButtonFormField(
    iconSize: 24,
    items: liste
        .map<DropdownMenuItem<String>>(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList(),
    onChanged: (String newValue) {
      changeFunction(newValue);
    },
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(30, 0, 0, 0),
      hintText: "5",
      border: OutlineInputBorder(
        gapPadding: 0,
        borderSide: BorderSide(color: Colors.black87),
      ),
    ),
  );
}
