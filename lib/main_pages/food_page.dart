import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Container(
        child: _goToSubPage(),
      ),
    );
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
