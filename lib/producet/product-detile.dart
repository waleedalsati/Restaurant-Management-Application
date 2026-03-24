
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Home/food/modelffod.dart';

import '../cart (2)/dart/Blocs/Bloc-add-cart/addcart-cubit.dart';
import '../cart (2)/dart/Blocs/Bloc-show-all-cart/show-all-cart-cubit.dart';
import '../cart (2)/dart/Blocs/Bloc-show-all-cart/show-all-cart-state.dart';
import '../presentation/add/AddFavoriteCubit.dart';
class product extends StatefulWidget {
  final foodmodel productt;
  const product({Key? key, required this.productt}) : super(key: key);
  @override
  State<product> createState() => _ProductPageState();
}
class _ProductPageState extends State<product> {
  int n = 0;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ShowCartCubit>().showcart();
    });
  }
  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://finer-needlessly-sawfish.ngrok-free.app/storage/foods/${widget.productt.photo}';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title:  Text(
          "Product Detail".tr(),
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<ShowCartCubit, ShowCartState>(
        builder: (context, state) {
          int originalQuantity =
              int.tryParse(widget.productt.quantity) ?? 0;
          int inCart = context
              .read<ShowCartCubit>()
              .getQuantityForProduct(widget.productt.id.toString());
          int availableQuantity = originalQuantity - inCart;

          // ضمان عدم تجاوز العدد المتاح
          if (n > availableQuantity) n = availableQuantity;

          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 16, right: 16),
                child: Image.network(
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 100),
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildIconButton(FontAwesomeIcons.plus, () {
                      if (n < availableQuantity) {
                        setState(() => n++);
                      }
                    }),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        '$n',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    buildIconButton(FontAwesomeIcons.minus, () {
                      if (n > 0) setState(() => n--);
                    }),


                    Padding(
                      padding: const EdgeInsets.only(left: 68.0),
                      child: IconButton(
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 28,
                        ),
                        onPressed: () {
                          BlocProvider.of<AddFavoriteCubit>(context)
                              .Addfavorite();
                          setState(() => isFavorite = !isFavorite);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: Text(
                  widget.productt.name,
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
              buildLabelValue('The price:'.tr(), '${widget.productt.price} \$'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "The description:".tr(),
                          style:
                          TextStyle(fontSize: 20, color: Colors.blue)),
                      TextSpan(
                        text: widget.productt.des,
                        style: const TextStyle(
                            fontSize: 20, color: Colors.black38),
                      ),
                    ],
                  ),
                ),
              ),
              buildLabelValue('The quantity left:'.tr(), '$availableQuantity'),
              buildLabelValue('Selected:'.tr(), '$n'),
              const SizedBox(height: 100),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding:
        const EdgeInsets.only(bottom: 18.0, left: 12, right: 12),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(60)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 20),
                child: Text(
                  '${(double.parse(widget.productt.price) * n).toStringAsFixed(2)} \$',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 15),
                child: IconButton(
                  onPressed: () async {
                    if (n > 0) {
                      final foodId = widget.productt.id.toString();
                      final addCartCubit =
                      BlocProvider.of<AddCartCubit>(context);

                      await addCartCubit.addCart(
                          foodid: foodId, foodnumber: n.toString(), );

                      setState(() => n = 0);


// تحديث السلة بعد الإضافة
                    context.read<ShowCartCubit>().showcart();
                    } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                    content: Text('يرجى تحديد عدد القطع'),
                    backgroundColor: Colors.red,
                    ),
                    );
                    }
                  },
                  icon: const Icon(Icons.add_shopping_cart,
                      color: Colors.white, size: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(16)),
      child: IconButton(
          onPressed: onPressed,
          icon: FaIcon(icon, color: Colors.white, size: 20)),
    );
  }

  Widget buildLabelValue(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(fontSize: 20, color: Colors.blue)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 20, color: Colors.black38)),
          ),
        ],
      ),
    );
  }
}