import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _name = 'Wutthichai Mahakaew';
  var _email = 'mahakaew_w@silpakorn.edu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Container(
                  width: 180.0,
                  height: 180.0,
                  child: Image.asset('assets/images/profile_pic.jpg'),
                )
            ),
            Text(
              _name,
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              _email,
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}