import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../on-Boarding/widgets/custom-textfiled.dart';

class EditBookingScreen extends StatefulWidget {
static String id ='EditBookingScreen';

  @override
  State<EditBookingScreen> createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends State<EditBookingScreen> {
  @override
  Widget build(BuildContext context) {
    final List<int> peopleCountOptions = List.generate(12, (index) => index + 1);

    return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.green,

    centerTitle: true,
    title: Text('EditBookingScreen'),
  ),
  body:ListView(
    children: [
Padding(
  padding: const EdgeInsets.only(top: 40.0),
  child: CustomTextField(
      hintText: 'enter the time',
      suffixIcon: Icon(Icons.access_time,color: Colors.green,),
      onChanged: (data){},
      inputetype: TextInputType.text,
      labelText: 'enter the time',
  ),
),
      const Text("Number of People", style: TextStyle(fontSize: 16)),
      const SizedBox(height: 8),
      // DropdownButtonFormField<int>(
      // //  value: selectedPeopleCount,
      //   items: peopleCountOptions.map((count) {
      //     return DropdownMenuItem(
      //       value: count,
      //       child: Text('$count'),
      //     );
      //   }).toList(),
      // //  onChanged: (val) => setState(() => selectedPeopleCount = val),
      //   decoration: InputDecoration(
      //     filled: true,
      //     fillColor: Colors.grey[200],
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(10),
      //       borderSide: BorderSide.none,
      //     ),
      //   ),
      // ),

    ],



  ) ,





);
  }
}
