import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Custombutten extends StatelessWidget
{
  final String?text;
final VoidCallback?ontap;
  const Custombutten({super.key,required this.text,required this.ontap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:ontap ,
      child: Container(

        height: 60,
        width:200 ,
        decoration: BoxDecoration(
          color: Colors.green,
      borderRadius: BorderRadius.circular(8),
        ),
        child:  Center(
          child: Text(text!,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff),


          ),

          ),
        ),



      ),
    );
  }

}