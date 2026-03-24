import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/Bloc-show-table/cubit-show-table.dart';
import '../Blocs/Bloc-show-table/state-show-table.dart';
import '../Blocs/Bloc-update/cubit-update.dart';
import '../Blocs/Bloc-update/state-update.dart';
import '../Blocs/Boc-delet-table/cubite-delete-table.dart';
import '../Blocs/Boc-delet-table/state-delete-table.dart';


class BookingListScreen extends StatelessWidget {
  static String id = 'BookingListScreen';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ReservationCubit()..fetchReservations()),
        BlocProvider(create: (_) => deletetablecubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Reservations'),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: BlocBuilder<ReservationCubit, ReservationState>(
          builder: (context, state) {
            if (state is ReservationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReservationFailure) {
              return Center(
                  child: Text(state.message,
                      style: const TextStyle(
                          color: Colors.red, fontSize: 16)));
            } else if (state is ReservationSuccess) {
              final reservations = state.reservations;
              if (reservations.isEmpty) {
                return const Center(
                    child: Text('No reservations yet.',
                        style:
                        TextStyle(fontSize: 16))

                );




              }

              return BlocListener<deletetablecubit, deletetablestate>(
                listener: (context, deleteState) {
                  if (deleteState is successdeletetable) {
                    BlocProvider.of<ReservationCubit>(context).fetchReservations();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(deleteState.massage),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (deleteState is failerdeletltable) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(deleteState.massage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: reservations.length,
                  itemBuilder: (context, index) {
                    final res = reservations[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(res.tableType.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text('${res.seats} seats',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    size: 16, color: Colors.green),
                                const SizedBox(width: 6),
                                Text(res.reservationDate,
                                    style: const TextStyle(fontSize: 14)),
                                const SizedBox(width: 16),
                                const Icon(Icons.access_time,
                                    size: 16, color: Colors.green),
                                const SizedBox(width: 6),
                                Text(res.reservationTime,
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // زر التعديل
                                ElevatedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        String? selectedTableType =
                                            res.tableType;
                                        int? selectedPeopleCount = res.seats;
                                        DateTime selectedDate = DateTime.parse(
                                            res.reservationDate);
                                        TimeOfDay selectedTime = TimeOfDay(
                                          hour: int.parse(res.reservationTime
                                              .split(':')[0]),
                                          minute: int.parse(res.reservationTime
                                              .split(':')[1]),
                                        );

                                        return BlocProvider(
                                          create: (_) =>
                                              EditReservationCubit(),
                                          child: BlocConsumer<EditReservationCubit,
                                              EditReservationState>(
                                            listener: (context, editState) {
                                              if (editState
                                              is EditReservationSuccess) {
                                                Navigator.pop(ctx);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content:
                                                    Text(editState.message),
                                                    backgroundColor:
                                                    Colors.green,
                                                  ),
                                                );
                                                BlocProvider.of<ReservationCubit>(
                                                    context)
                                                    .fetchReservations();
                                              } else if (editState
                                              is EditReservationFailure) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content:
                                                    Text(editState.message),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            },
                                            builder: (context, editState) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Edit Reservation'),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    children: [
                                                      DropdownButtonFormField<
                                                          String>(
                                                        value: selectedTableType,
                                                        items: [
                                                          'small',
                                                          'medium',
                                                          'large'
                                                        ]
                                                            .map((e) =>
                                                            DropdownMenuItem(
                                                              value: e,
                                                              child: Text(
                                                                  e.toUpperCase()),
                                                            ))
                                                            .toList(),
                                                        onChanged: (val) =>
                                                        selectedTableType =
                                                            val,
                                                        decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                            'Table Type'),
                                                      ),
                                                      const SizedBox(height: 10),
                                                      DropdownButtonFormField<int>(
                                                        value: selectedPeopleCount,
                                                        items: List.generate(
                                                            12, (index) => index + 1)
                                                            .map((e) =>
                                                            DropdownMenuItem(
                                                              value: e,
                                                              child: Text('$e'),
                                                            ))
                                                            .toList(),
                                                        onChanged: (val) =>
                                                        selectedPeopleCount =
                                                            val,
                                                        decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                            'Seats'),
                                                      ),
                                                      const SizedBox(height: 10),
                                                      InkWell(
                                                        onTap: () async {
                                                          final date = await showDatePicker(
                                                            context: context,
                                                            initialDate: selectedDate,
                                                            firstDate: DateTime.now(),
                                                            lastDate: DateTime.now().add(const Duration(days: 365)),
                                                          );
                                                          if (date != null) selectedDate = date;
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.all(12),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('${selectedDate.year}-${selectedDate.month.toString().padLeft(2,'0')}-${selectedDate.day.toString().padLeft(2,'0')}'),
                                                              const Icon(Icons.calendar_today),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10),
                                                      InkWell(
                                                        onTap: () async {
                                                          final time = await showTimePicker(
                                                            context: context,
                                                            initialTime: selectedTime,
                                                          );
                                                          if (time != null) selectedTime = time;
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.all(12),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('${selectedTime.format(context)}'),
                                                              const Icon(Icons.access_time),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(ctx),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      if (selectedTableType != null &&
                                                          selectedPeopleCount != null) {
                                                        BlocProvider.of<EditReservationCubit>(context).editReservation(
                                                          id: res.id,
                                                          tableType: selectedTableType!,
                                                          seats: selectedPeopleCount!,
                                                          date: '${selectedDate.year}-${selectedDate.month.toString().padLeft(2,'0')}-${selectedDate.day.toString().padLeft(2,'0')}',
                                                          time: '${selectedTime.hour.toString().padLeft(2,'0')}:${selectedTime.minute.toString().padLeft(2,'0')}',
                                                        );
                                                      }
                                                    },
                                                    child: const Text('Save'),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.edit, size: 18),
                                  label: const Text('Edit'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    textStyle: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // زر الحذف كما هو
                                ElevatedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text('Confirm Delete'),
                                        content: const Text(
                                            'Are you sure you want to delete this reservation?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(ctx),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(ctx);
                                              BlocProvider.of<deletetablecubit>(context)
                                                  .deletetable(res.id);
                                            },
                                            child: const Text('Delete',
                                                style:
                                                TextStyle(color: Colors.red)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete, size: 18),
                                  label: const Text('Delete'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    textStyle: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
