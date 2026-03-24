import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../cart (2)/dart/Blocs/Bloc-delete-cart/delete-cart-cubit.dart';
import '../../cart (2)/dart/Blocs/Bloc-delete-cart/delete-cart-state.dart';
import 'Bloc-myorder/cubit-myorder.dart';
import 'Bloc-myorder/state-myorder.dart';


class ConfirmedOrdersPage extends StatelessWidget {
  static String routeId = 'confirmed_orders';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ConfirmedOrdersCubit()..fetchConfirmedOrders(),
        ),
        BlocProvider(
          create: (_) => deletecartcubit(),
        ),
      ],
      child: BlocBuilder<ConfirmedOrdersCubit, ConfirmedOrdersState>(
        builder: (context, state) {
          if (state is ConfirmedOrdersLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ConfirmedOrdersFailure) {
            return Scaffold(
              body: Center(child: Text("Error: ${state.error}")),
            );
          } else if (state is ConfirmedOrdersSuccess) {
            final items = state.items;
            if (items.isEmpty) {
              return const Scaffold(
                body: Center(child: Text("No confirmed orders.")),
              );
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text("Confirmed Orders"),
                backgroundColor: Colors.green,
              ),
              body: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = items[index];

                  // تحديد لون الحالة حسب قيمة status
                  Color statusColor;
                  switch (item.status) {
                    case 'Pending':
                      statusColor = Colors.orange;
                      break;
                    case 'Completed':
                      statusColor = Colors.green;
                      break;
                    case 'In Service':
                      statusColor = Colors.blue;
                      break;
                    case 'Out for Delivery':
                      statusColor = Colors.purple;
                      break;
                    case 'Rejected':
                      statusColor = Colors.red;
                      break;
                    default:
                      statusColor = Colors.grey;
                  }

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.food.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text('Quantity: ${item.quantity}'),
                          Text('Price: ${item.price.toStringAsFixed(2)}\$'),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status: ${item.status}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: statusColor,
                                ),
                              ),
                              Text(item.createdAt.split('T').first),

                              if (item.status == 'Completed')
                                BlocConsumer<deletecartcubit, deletecartstate>(
                                  listener: (context, deleteState) {
                                    if (deleteState is successdeletecart) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(deleteState.massage),
                                          backgroundColor: Colors.green,
                                        ),
                                      );

                                      BlocProvider.of<ConfirmedOrdersCubit>(
                                          context).fetchConfirmedOrders();
                                    } else if (deleteState
                                    is failerdeletlcart) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(deleteState.massage),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, deleteState) {

                                    return IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<deletecartcubit>(
                                            context)
                                            .deleteCart(item.orderId);
                                      },
                                    );
                                  },
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
          }

          return const SizedBox();
        },
      ),
    );
  }
}
