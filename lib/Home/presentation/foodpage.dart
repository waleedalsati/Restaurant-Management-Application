import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../producet/product-detile.dart';
import '../food/foodcubit.dart';
import '../food/foodstate.dart';
class FoodDisplayPage extends StatelessWidget {
  static String id ='FoodDisplayPage';
  const FoodDisplayPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("The Foods".tr()),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<foodcubit, foodstate>(
        builder: (context, state) {
          if (state is foodloding) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is foodsuccess) {
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.food.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final food = state.food[index];
                final imageUrl =
                    'https://finer-needlessly-sawfish.ngrok-free.app/storage/foods/${food.photo}';

                return Card(
                  elevation: 4,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: InkWell(
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => product(productt: food)),
                      );

                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            imageUrl,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 80),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                food.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              const SizedBox(height: 6),
                              Text(
                                '${food.price} \$',
                                style: const TextStyle(
                                    color: Colors.green, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is foodfailer) {
            return Center(child: Text(': ${state.massage}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

}