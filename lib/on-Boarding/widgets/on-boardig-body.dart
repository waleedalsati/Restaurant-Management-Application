import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../Auth/login/presentation/login.dart';
import 'custom-Button.dart';
import 'custom-indicator.dart';
import 'custom-page-view.dart';
class onboardingbody extends StatefulWidget
{
  @override
  State<onboardingbody> createState() => _onboardingbodyState();
}
class _onboardingbodyState extends State<onboardingbody> {
  PageController?pagee;
  @override
  void initState() {
    pagee=PageController(initialPage: 0
    )..addListener((){
      setState(() {
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Stack
     (
     children: [
       CustemPageView(page: pagee,),
       Positioned(
         bottom: 190,
           left: 0,
           right: 0,
           child:CustomIndicator(dotsindex:pagee!.hasClients? pagee?.page:0),

       ),
       Positioned(
         top:60,
         right: 32,
         child: Visibility(
           visible:pagee!.hasClients?( pagee?.page==2?false:true) :true,
           child: const Text(
               'Skip',
             style: TextStyle(
               fontSize: 14,
               color: Color(0xff898989),
             ),
             textAlign: TextAlign.right,

           ),
         ),
       ),
       Positioned(
           bottom: 90,
           right: 90,
               child: Custombutten(
                 ontap: ()
                 {
                   if(pagee!.page!<2)
                     {
                       pagee?.nextPage(duration: Duration(milliseconds: 500),
                           curve: Curves.easeIn);
                     }
                   else
                     {
                       Navigator.pushNamed(context, Login.id);
                     }
                 },
                 text:pagee!.hasClients?(pagee?.page==2?'Get started':'Next'):'next',))
     ],
   );
  }
}