class ShowCartModel {
  final String orderid;
  final String foodid;
  final String foodphoto;
  final String foodname;
  final String foodprice;
  final String qunreq;
  final String itemtotalprice;
  ShowCartModel({
    required this.orderid,
    required this.foodid,
    required this.foodphoto,
    required this.foodname,
    required this.foodprice,
    required this.qunreq,
    required this.itemtotalprice,
  });
  factory ShowCartModel.fromJson(Map<String, dynamic> json) {
    return ShowCartModel(
      orderid: json['order_id']?.toString() ?? '',
      foodid: json['food_id']?.toString() ?? '',
      foodphoto: json['food_photo']?.toString() ?? '',
      foodname: json['food_name']?.toString() ?? '',
      foodprice: json['food_price']?.toString() ?? '',
      qunreq: json['quantity_requested']?.toString() ?? '',
      itemtotalprice: json['item_total_price']?.toString() ?? '',
    );
  }
  @override
  String toString() {
    return 'CartItem: { name: $foodname, price: $foodprice, qty: $qunreq }';
  }
}