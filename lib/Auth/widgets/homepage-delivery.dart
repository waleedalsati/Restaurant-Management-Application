import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homepagedel extends StatelessWidget {
 static String id='homepagedel';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

appBar: AppBar(
  backgroundColor: Colors.white,
),

        body:  Card(
          color: Colors.green,
          elevation: 20,
          child: Container(
            height: 53,
            width: 620,
            child: Row(
              children: [
               IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: Colors.white,)),

                const SizedBox(width: 95,),
                const Text('oreder managment ',style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        ),



    );
  }
}
