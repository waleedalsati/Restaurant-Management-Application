import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget
{
  final double? dotsindex;

  const CustomIndicator({super.key,@required this.dotsindex});
  @override
  Widget build(BuildContext context) {
  return  DotsIndicator(
    decorator: DotsDecorator(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.green,

          ),
          borderRadius: BorderRadius.circular(8),
        ),
        activeColor: Colors.green


    ),
    dotsCount: 3,position: dotsindex!,

  );
  }


}