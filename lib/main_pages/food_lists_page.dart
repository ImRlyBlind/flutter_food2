import 'package:flutter/material.dart';

class FoodListsPage extends StatefulWidget {
  const FoodListsPage({Key? key}) : super(key: key);

  @override
  _FoodListsPageState createState() => _FoodListsPageState();
}

class _FoodListsPageState extends State<FoodListsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'FOOD MENU',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
