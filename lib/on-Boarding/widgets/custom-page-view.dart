import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectweather/on-Boarding/widgets/page-view-item.dart';


class CustemPageView extends StatelessWidget
{
  final PageController?page;
  const CustemPageView({super.key,@required this.page});
  @override
  Widget build(BuildContext context) {
    return PageView(
    controller:page ,
      children: const [
        pageviewitem(
            title: 'HELLO OUR RESTAURANT',
            subtitle: 'Explore Top organic Fruit',
            image: 'lib/anamation/Animation - 1745391037952.json',
        ),
        pageviewitem(
            title: 'Delivery on the way',
            subtitle: 'Get your order by speed delivery',
            image: 'lib/anamation/Animation - 1745162795791.json'
        ),
        pageviewitem(
            title: 'Delivery arrived',
            subtitle: 'order is arrived at your place',
            image: 'lib/anamation/Animation - 1745389238633.json'
        ),
      ],
    );
  }
}