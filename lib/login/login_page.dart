import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food2/home/home_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var input = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.tealAccent.shade100,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 80.0,
                      ),
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        'Enter Pin to login',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 6; ++i)
                          if (input.length <= i)
                            Icon(
                              Icons.circle_outlined,
                              size: 35,
                              color: Colors.tealAccent.shade400,
                            )
                          else
                            Icon(
                              Icons.circle,
                              size: 35,
                              color: Colors.tealAccent.shade700,
                            )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                //color: Colors.pink,
                child: Column(
                  children: [
                    [1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9],
                    [-2, 0, -1],
                  ]
                      .map(
                        (row) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row
                          .map((item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LoginButton(
                          number: item,
                          onClick: _handleClickButton,
                        ),
                      ))
                          .toList(),
                    ),
                  )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showMessageAndClearPIN() {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text('Invalid PIN. Please try again.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
    input = '';
  }

  void _handleClickButton(int num) {
    print(num);
    setState(() {
      if (num != -1 && input.length < 6) {
        input += '$num';
      } else if (num == -1) {
        if (input.length > 0) {
          input = input.substring(0, input.length - 1);
        }
      }
      if (input.length == 6 && input != '123456') {
        showMessageAndClearPIN();
      } else if (input.length == 6 && input == '123456') {
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      }
    });
  }
}

class LoginButton extends StatelessWidget {
  final int number;
  final Function(int) onClick;

  const LoginButton({
    required this.number,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: number == -2 ? null : () => onClick(number),
      child: Container(
        width: 65,
        height: 65,
        decoration: number == -2
            ? null
            : BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2),
          color: Colors.amberAccent.withAlpha(50),
        ),
        child: Center(
          child: number >= 0
              ? Text(
            '$number',
            style: Theme.of(context).textTheme.headline6,
          )
              : (number == -1
              ? Icon(
            Icons.backspace_outlined,
            size: 28,
          )
              : SizedBox.shrink()),
        ),
      ),
    );
  }
}
