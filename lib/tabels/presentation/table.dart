import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/Bloc-tabel/cubit-table.dart';
import '../Blocs/Bloc-tabel/state-table.dart';
import 'BookingListScreen.dart';
import 'package:intl/intl.dart';


class TableBookingScreen extends StatefulWidget {
  static String id = 'TableBookingScreen';

  @override
  State<TableBookingScreen> createState() => _TableBookingScreenState();
}

class _TableBookingScreenState extends State<TableBookingScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int? selectedPeopleCount;
  String? selectedTableType;

  final List<int> peopleCountOptions = List.generate(10, (index) => index + 1);


  final Map<String, String> tableTypes = {
    'small': 'Small (1-3 people)',
    'medium': 'Medium (1-6 people)',
    'large': 'Large (1-10 people)',
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubittable(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Table Reservation Request"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: BlocConsumer<cubittable, statetable>(
          listener: (context, state) {
            if (state is successtable) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.massage),backgroundColor: Colors.green,),
              );
              Navigator.pushNamed(context, BookingListScreen.id);
            } else if (state is failertable) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.massage),backgroundColor: Colors.red,),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text("Reservation Date", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 30)),
                        );
                        if (date != null) {
                          setState(() => selectedDate = date);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(selectedDate!) // Y-m-d
                              : 'Select date',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // وقت الحجز
                    const Text("Reservation Time", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() => selectedTime = time);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          selectedTime != null
                              ? '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}' // H:i
                              : 'Select time',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text("Number of People", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: selectedPeopleCount,
                      items: peopleCountOptions.map((count) {
                        return DropdownMenuItem(
                          value: count,
                          child: Text('$count'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => selectedPeopleCount = val),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // نوع الطاولة
                    const Text("Table Type", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedTableType,
                      items: tableTypes.entries.map((entry) {
                        return DropdownMenuItem(
                          value: entry.key,     // small/medium/large للباك
                          child: Text(entry.value), // يظهر للمستخدم
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => selectedTableType = val),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    // زر تأكيد الحجز
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedDate != null &&
                              selectedTime != null &&
                              selectedPeopleCount != null &&
                              selectedTableType != null) {

                            final dateFormatted = DateFormat('yyyy-MM-dd').format(selectedDate!);
                            final timeFormatted =
                                '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}';
                            final tableFormatted = selectedTableType!.toLowerCase();

                            print("SENT VALUES => "
                                "date: $dateFormatted, "
                                "time: $timeFormatted, "
                                "people: $selectedPeopleCount, "
                                "table: $tableFormatted");

                            context.read<cubittable>().table(
                              tabletype: tableFormatted,  // small/medium/large
                              number: selectedPeopleCount!,
                              data: dateFormatted,        // 2025-08-26
                              time: timeFormatted,        // 18:37
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill in all fields')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state is loadingtable
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Confirm Reservation", style: TextStyle(fontSize: 18)),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
