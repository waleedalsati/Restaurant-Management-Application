import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../on-Boarding/widgets/custom-textfiled.dart';
import 'new-passwoerd.dart';

class Verfiycode extends StatelessWidget {
  const Verfiycode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 14.0),
            child: Text('Verify code',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
              ),),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 14.0),
            child: Text('Please enter the code we just sent you',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),),
          ),
const SizedBox(height: 30,),
        CustomTextField(hintText: 'enter cod',
            suffixIcon: Icon(Icons.code), onChanged: (data){},
            inputetype: TextInputType.text, labelText: 'enter code'),
        const SizedBox(height: 30,),

         Padding(padding: const EdgeInsets.only(top: 10,left: 50,right: 50),
            child: Container(child:  TextButton(onPressed: (){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>pageNewPassowrd()))   ;

  }, child: Text('Continue',style:TextStyle(fontSize: 15,color: Colors.white) ,)) ,decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(9) ,color: Colors.green)),

          ),




        ]
      ),
    );
  }
}