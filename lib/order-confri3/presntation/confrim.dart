import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../cart (2)/dart/Blocs/Bloc-show-all-cart/show-all-cart-cubit.dart';
import '../../cart (2)/dart/Blocs/Bloc-show-all-cart/show-all-cart-state.dart';
import 'Bloc-confirm/confrim-cubit.dart';
import 'Bloc-confirm/confrim-state.dart';

class OrderConfirmationPage extends StatefulWidget {
  static String routeId = 'order_confirmation';
  @override
  _OrderConfirmationPageState createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  final TextEditingController locationController = TextEditingController();
  final Map<int, bool> confirmedItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Confirm Your Order",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: Colors.green,
        elevation: 4,
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<confrimcubit, confrim>(
            listener: (context, state) {
              if (state is successconfrim) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.massage),
                    backgroundColor: Colors.green,

                  ),

                );
                BlocProvider.of<ShowCartCubit>(context).showcart();
              } else if (state is faliarconfrim) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.massage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<ShowCartCubit, ShowCartState>(
          builder: (context, cartState) {
            if (cartState is LoadingShowCart) {
              return const Center(child: CircularProgressIndicator());
            } else if (cartState is SuccessShowCart) {
              final items = cartState.items ?? [];
              final total = cartState.totalPrice ?? 0.0;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.green[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        labelText: "Delivery Address",
                        hintText: "Enter your location",
                        prefixIcon: const Icon(Icons.location_on, color: Colors.green),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final price = double.tryParse(item.foodprice ?? "0") ?? 0;
                          final qty = int.tryParse(item.qunreq) ?? 0;
                          final isConfirmed = confirmedItems[item.orderid] ?? false;

                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: isConfirmed ? Colors.green[50] : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      'https://finer-needlessly-sawfish.ngrok-free.app/storage/foods/${item.foodphoto}',
                                      height: 60,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.broken_image, size: 90, color: Colors.grey);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${item.foodname}' ?? "",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: isConfirmed ? Colors.blue : Colors.blue,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Text('quantity: $qty', style: TextStyle(color: Colors.grey[700])),
                                        const SizedBox(height: 6),
                                        Text('price: ${price.toStringAsFixed(2)}\$',
                                            style: TextStyle(color: Colors.grey[700])),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    children: [
                                      Text(
                                        '${(price * qty).toStringAsFixed(2)}\$',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepOrange),
                                      ),
                                      const SizedBox(height: 6),
                                      GestureDetector(
                                        onTap: isConfirmed
                                            ? null
                                            : () {
                                          final location = locationController.text.trim();

                                          if (location.isEmpty) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Please enter your delivery location'),
                                              ),
                                            );
                                            return;
                                          }

                                          BlocProvider.of<confrimcubit>(context).confim(
                                            orderid: int.tryParse(item.orderid) ?? 0,
                                            location: location,
                                          );

                                          setState(() {
                                            confirmedItems[int.parse(item.orderid)] = true;
                                          });
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: isConfirmed
                                                ? const LinearGradient(
                                              colors: [Colors.green, Colors.lightGreen],
                                            )
                                                : LinearGradient(
                                              colors: [Colors.grey.shade300, Colors.grey.shade400],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.4),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Icon(
                                              isConfirmed ? Icons.check : Icons.done,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "$total\$",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (cartState is FailureShowCart) {
              return Center(child: Text("Error: ${cartState.message}"));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
