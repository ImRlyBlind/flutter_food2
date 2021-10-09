import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_food2/models/food_items.dart';

class FoodDetailPage extends StatefulWidget {
  static const routeName = '/foodDetail';

  const FoodDetailPage({Key? key}) : super(key: key);

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  Widget build(BuildContext context) {
    var detail = ModalRoute.of(context)!.settings.arguments as FoodItem;
    return Scaffold(
      appBar: AppBar(
        title: Text(detail.name),
        backgroundColor: Colors.lightBlue.withAlpha(100),
      ),
      body: Container(
        child: Center(
          child: ListView(children: [
            Image.asset(
              'assets/images/${detail.image}',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ชื่อเมนู: ${detail.name}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'ราคา: ${detail.price} บาท',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
