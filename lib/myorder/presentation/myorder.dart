import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String? mealName = "برغر دجاج";
  int? quantity = 3;
  String? deliveryLocation = "الرياض، حي العليا";

  void deleteOrder() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تأكيد الحذف'),
        content: Text('هل أنت متأكد من حذف الطلب؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                mealName = null;
                quantity = null;
                deliveryLocation = null;
              });
              Navigator.pop(context);
            },
            child: Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void navigateToTracking() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrackingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تفاصيل الطلب'), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: mealName == null
            ? Center(child: Text("لا توجد طلبات حالياً"))
            : Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.fastfood, size: 40, color: Colors.orange),
                title: Text('الوجبة: $mealName',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text('الكمية: $quantity'),
                    SizedBox(height: 4),
                    Text('الموقع: $deliveryLocation'),
                  ],
                ),
                trailing: Icon(Icons.location_on, color: Colors.red),
                contentPadding: EdgeInsets.all(16),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: navigateToTracking,
              icon: Icon(Icons.delivery_dining),
              label: Text('تتبع الطلب'),
            ),
          ],
        ),
      ),
    );
  }
}

class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final List<String> statuses = [
    "تم استلام الطلب",
    "قيد التحضير",
    "جاري التوصيل",
    "تم التوصيل",
  ];

  int currentStep = 1;

  void _advanceStatus() {
    setState(() {
      if (currentStep < statuses.length - 1) {
        currentStep++;
        if (currentStep == statuses.length - 1) {
          _showDeliveredAnimation();
        }
      }
    });
  }


  void _showDeliveredAnimation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200,
              child: Lottie.asset('lib1/anamation/Animation - 1750233513501.json'), // ملف الأنيميشن
            ),
            SizedBox(height: 16),
            Text(
              'تم التوصيل بنجاح!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('حسناً'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getStatusColor(int index) {
    if (index < currentStep) return Colors.green[300]!;
    if (index == currentStep) return Colors.green;
    return Colors.grey[400]!;
  }

  IconData getIcon(int index) {
    if (index < currentStep) return Icons.check_circle;
    if (index == currentStep) return Icons.delivery_dining;
    return Icons.radio_button_unchecked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("تتبع الطلب"),
          backgroundColor: Colors.green,
        ),
        body: Column(
            children: [
            SizedBox(height: 16),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: statuses.length,
        //     itemBuilder: (context, index) {
        //       return TimelineTile(
        //         alignment: TimelineAlign.manual,
        //         lineXY: 0.1,
        //         isFirst: index == 0,
        //         isLast: index == statuses.length - 1,
        //         indicatorStyle: IndicatorStyle(
        //           width: 36,
        //           color: getStatusColor(index),
        //           iconStyle: IconStyle(
        //             iconData: getIcon(index),
        //             color: Colors.white,
        //           ),
        //         ),
        //         beforeLineStyle: LineStyle(
        //           color: getStatusColor(index),
        //           thickness: 4,
        //         ),
        //         endChild: Container(
        //           margin: const EdgeInsets.all(12),
        //           padding: const EdgeInsets.all(16),
        //           decoration: BoxDecoration(
        //             color: getStatusColor(index).withOpacity(0.1),
        //             borderRadius: BorderRadius.circular(12),
        //             border: Border.all(color: getStatusColor(index), width: 1.2),
        //           ),
        //           child: Text(
        //             statuses[index],
        //             style: TextStyle(
        //               fontSize: 18,
        //               fontWeight: index == currentStep ? FontWeight.bold : FontWeight.normal,
        //               color: getStatusColor(index).withOpacity(0.9),
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        if (currentStep < statuses.length - 1)
    Padding(
      padding: const EdgeInsets.only(bottom: 56.0, left: 30, right: 30),
      child: ElevatedButton.icon(
        onPressed: _advanceStatus,
        icon: Icon(Icons.refresh),
        label: Text("تحديث حالة الطلب"),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            textStyle: TextStyle(fontSize: 16),

            shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    ),
    ),
    ],
    ),
    );
  }
}