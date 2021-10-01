import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food2/main_pages/food_page.dart';
import 'package:flutter_food2/main_pages/profile_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _subPageIndex = 0;
  var _name = 'Wutthichai Mahakaew';
  var _email = 'mahakaew_w@silpakorn.edu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _header(_subPageIndex),
        backgroundColor: Colors.lightBlue.withAlpha(100),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue,
                    Colors.white,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        child: Image.asset('assets/images/profile_pic.jpg'),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _name,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          _email,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () => _showSubPage(0),
              title: _buildDrawerItem(
                Icon(
                  Icons.fastfood,
                  color: _subPageIndex == 0 ? Colors.blue : Colors.black,
                ),
                Text(
                  'FOOD',
                  style: TextStyle(
                    color: _subPageIndex == 0 ? Colors.blue : Colors.black,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () => _showSubPage(1),
              title: _buildDrawerItem(
                Icon(
                  Icons.person,
                  color: _subPageIndex == 1 ? Colors.blue : Colors.black,
                ),
                Text(
                  'PROFILE',
                  style: TextStyle(
                    color: _subPageIndex == 1 ? Colors.blue : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: _goToSubPage(),
      ),
    );
  }

  _showSubPage(int index) {
    setState(() {
      _subPageIndex = index;
    });
    Navigator.of(context).pop();
  }

  Widget _goToSubPage() {
    switch (_subPageIndex) {
      case 0:
        return FoodPage();
      case 1:
        return ProfilePage();
      default:
        return SizedBox.shrink();
    }
  }

  Text _header(int index) {
    switch (index) {
      case 0:
        return Text('Food');
      case 1:
        return Text('Profile');
      default:
        return Text('Flutter Food');
    }
  }

  Row _buildDrawerItem(Widget icon, Widget title) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 8,
        ),
        title,
      ],
    );
  }
}
