import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'on-boarding-view.dart';
import 'dart:async';
class ScreenSplash extends StatefulWidget {
  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState()
  {
    Future.delayed(Duration(seconds: 5),(){
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>onBoardingview()));});
    
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Center(child: LottieBuilder.asset('lib/anamation/Animation - 1747248564997.json')),

    );
  }
}