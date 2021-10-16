import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food2/models/food_items.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_food2/main_pages/food_lists_page.dart';
import 'package:flutter_food2/main_pages/order_page.dart';

class FoodPage extends StatefulWidget {
  static const routeName = '/food';

  const FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  var _selectedBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book,
              color: _selectedBottomNavIndex == 0 ? Colors.blue.shade400 : Colors.black,
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: _selectedBottomNavIndex == 1 ? Colors.blue.shade400 : Colors.black,
            ),
            label: 'Your Order',
          ),
        ],
        currentIndex: _selectedBottomNavIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _test,
        child: Icon(Icons.add),
      ),
      body: Container(
        child: _goToSubPage(),
      ),
    );
  }

  Future<void> _test() async {
    var url = Uri.parse('https://cpsu-test-api.herokuapp.com/foods');
    var response = await http.post(url, body: {
      "pin": '123456'
    });

    if(response.statusCode == 200){
      Map<String, dynamic> jsonBody = json.decode(response.body);
      String status = jsonBody['status'];
      String? message = jsonBody['message'];
      List<dynamic> data = jsonBody['data'];

      var foodList = data.map((element) => FoodItem(
        id: element['id'],
        name: element['name'],
        price: element['price'],
        image: element['image'],
      )).toList();

      /*data.forEach((element) {
        FoodItem(
          id: element['id'],
          name: element['name'],
          price: element['price'],
          image: element['image'],
        );
      });*/
    }
  }

  Widget _goToSubPage() {
    switch (_selectedBottomNavIndex) {
      case 0:
        return FoodListsPage();
      case 1:
        return OrderPage();
      default:
        return SizedBox.shrink();
    }
  }
}
