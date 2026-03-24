import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Home/food/foodcubit.dart';
import '../../order-confri3/presntation/confrim.dart';

import 'Blocs/Bloc-delete-cart/delete-cart-cubit.dart';
import 'Blocs/Bloc-delete-cart/delete-cart-state.dart';
import 'Blocs/Bloc-show-all-cart/show-all-cart-cubit.dart';
import 'Blocs/Bloc-show-all-cart/show-all-cart-state.dart';
import 'Blocs/Bloc-update/update-cart-cubit.dart';
import 'Blocs/Bloc-update/update-cart-state.dart';
class cart extends StatelessWidget
{
  static String id = 'cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BodyCart(),
    );
  }
}
class BodyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<deletecartcubit,deletecartstate>(
      listener:(context,state)async
      {
        if(state is successdeletecart)
          {
            await BlocProvider.of<ShowCartCubit>(context).showcart();
            await BlocProvider.of<foodcubit>(context).food(1);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${state.massage}'),backgroundColor: Colors.green,)
            );

          }
        else if (state is failerdeletlcart)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${state.massage}'))

            );
          }
      },
      child: BlocListener<UpdateCartCubit, updatecartstate>(
        listener: (context, state) async {
          if (state is successupdatecart) {
            await BlocProvider.of<foodcubit>(context).food(1);
            await BlocProvider.of<ShowCartCubit>(context).showcart();
            final updated = state.items.first;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.massage}quantity update to ${updated.foodsNumber} and price ${updated.price}'),backgroundColor: Colors.green,
              ),
            );
          } else if (state is failerupdatecart) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('فشل التعديل:${state.massage}'),
              ),
            );
          }
        },
        child: BlocBuilder<ShowCartCubit, ShowCartState>(
          builder: (context, state) {
            if (state is LoadingShowCart) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SuccessShowCart) {
              final items = state.items;
              final total = state.totalPrice;

              return ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  ...items.map((item) {
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [

                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:Image.network(
                                'https://finer-needlessly-sawfish.ngrok-free.app/storage/foods/${item.foodphoto}',
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.broken_image,
                                    size: 90,
                                    color: Colors.grey,
                                  );
                                },
                              )

                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.foodname,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      )),
                                  const SizedBox(height: 6),
                                  Text('${item.foodprice} \$ × ${item.qunreq}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      )),
                                ],
                              ),
                            ),

                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.green),
                                  onPressed: () {
                                    final quantityController = TextEditingController(text: item.qunreq.toString());
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Edit Quantity"),
                                          content: TextField(
                                            controller: quantityController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              labelText: "New Quantity",
                                              suffixIcon: Icon(Icons.edit),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                final newQuantityText = quantityController.text.trim();
                                                final newQuantity = int.tryParse(newQuantityText);

                                                if (newQuantity == null || newQuantity <= 0) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(content: Text('الرجاء إدخال كمية صحيحة')),
                                                  );
                                                  return;
                                                }

                                                BlocProvider.of<UpdateCartCubit>(context).updateCart(
                                                  orderId: int.parse(item.orderid),
                                                  newFoodId: int.parse(item.foodid),
                                                  newFoodNumber: newQuantity,
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Confirm"),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text("Cancel"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_forever, color: Colors.red),
                                  onPressed: () {
                                    BlocProvider.of<deletecartcubit>(context).deleteCart(int.parse(item.orderid));
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 20),


                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.price_change_rounded, color: Colors.green),
                            SizedBox(width: 8),
                            Text('Total Cost:',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text('$total \$',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // زر التأكيد
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OrderConfirmationPage()),
                        );
                      },
                      child: const Text(
                        "Go to Order Confirmation",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              );

            } else if (state is FailureShowCart) {
              return Center(child: Text("Error: ${state.message}"));
            }
            else
            {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
