import 'package:flutter/material.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('معلومات التطبيق'),backgroundColor: Colors.green,),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const ListTile(
              leading: Icon(Icons.help_outline, color: Colors.blue),
              title: Text('رقم الاستفسار'),
              subtitle: Text('0966000000'),

            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const ListTile(
              leading: Icon(Icons.event_available, color: Colors.green),
              title: Text('ارقام الدلفري فوري '),
              subtitle: Text('0966111111'),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: const ListTile(
              leading: Icon(Icons.report_problem, color: Colors.red),
              title: Text('رقم الشكوى'),
              subtitle: Text('0966222222'),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'حول التطبيق:\nهذا التطبيق يقدم خدمات الاستفسار والحجز وتقديم الشكاوى بطريقة سهلة وسريعة.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 90),
          Text(
            'نرحب بكم زورونا تسرونا',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25,color: Colors.green),
          )
        ],
      ),
    );
  }
}

