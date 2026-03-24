import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  CustomTextField({required this.hintText,@required this.suffixIcon,required this.onChanged ,required this.inputetype,required this.labelText});
  Function(String)? onChanged;
  String? hintText;
  Icon?suffixIcon;
  String?labelText;
  TextInputType? inputetype;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
      child: TextField
        (

        keyboardType:inputetype ,
        onChanged: onChanged,
        decoration: InputDecoration
          (
          suffixIcon:suffixIcon ,

          hintText: hintText,
          labelText: labelText,

          hintStyle: const TextStyle
            (
            color: Colors.black54,
          ),
          enabledBorder: OutlineInputBorder
            (

            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide
              (
              color: Colors.green,
            ),
          ),
          border: OutlineInputBorder
            (
            borderRadius: BorderRadius.circular(60),
            borderSide: const BorderSide
              (
            color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}