import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food2/home/home_page.dart';
import 'package:http/http.dart' as http;

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

  void _showMessage() {
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
  }

  void _handleClickButton(int num) {
    setState(() {
      if (num == -1) {
        if (input.length > 0) {
          input = input.substring(0, input.length - 1);
        }
      } else {
        input = '$input$num';
      }
      if (input.length == 6) {
        _checkPin(input);
      }
    });
  }

  Future<void> _checkPin(String pin) async {
    var url = Uri.parse('https://cpsu-test-api.herokuapp.com/login');
    var isPin = await http.post(url, body: {'pin': pin});

    if (isPin.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(isPin.body);
      bool data = jsonBody['data'];
      //print(data);
      if (data) {
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      } else {
        setState(() {
          input = '';
        });
        _showMessage();
      }
    }
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
