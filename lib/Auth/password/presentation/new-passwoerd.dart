import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../on-Boarding/widgets/custom-textfiled.dart';

class pageNewPassowrd extends StatelessWidget {
  const pageNewPassowrd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
              'Create new password',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
           ),
          const Padding(
      padding:  EdgeInsets.only(left: 12.0),        child: Text(
              'your new password must be offerd from previous used password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
          ),
const SizedBox(
  height: 30,
),
         CustomTextField(
             hintText: 'new password',
             suffixIcon: Icon(Icons.remove_red_eye),
             onChanged:(data){},
             inputetype:TextInputType.text,
             labelText: 'new password'),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
              hintText: 'repet password',
              suffixIcon: Icon(Icons.remove_red_eye),
              onChanged:(data){},
              inputetype:TextInputType.text,
              labelText: 'repet password'),
          const SizedBox(

            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 50, right: 50),
            child: Container(
              child: TextButton(
                onPressed: () {},
                child: Text('Submit', style: TextStyle(fontSize: 15,color: Colors.white)),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),

    );
  }
}