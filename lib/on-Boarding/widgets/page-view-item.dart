import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class pageviewitem extends StatelessWidget
{
  final String?title;
  final String? subtitle;
  final String? image;

  const pageviewitem({super.key, required this.title, required this.subtitle, required this.image});
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        LottieBuilder.asset(image!,height: 300,),
         const SizedBox(
           height: 25,

         ),
         Text(
            title !,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),


        ),
        const SizedBox(
          height: 19,

        ),
         Text(
          subtitle!,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.green,
            fontWeight: FontWeight.bold,


          ),

        )
      ],




    );
  }


}