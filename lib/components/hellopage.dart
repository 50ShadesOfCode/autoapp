import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelloPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 30,
              right: 10,
              child: IconButton(
                icon: new Icon(CupertinoIcons.star),
                onPressed: () => {},
              )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Здравствуйте! Вы готовы приступить?'),
                Image.asset(
                  'assets/images/car_logo.png',
                  width: 200,
                  height: 200,
                ),
                TextButton(onPressed: () => {}, child: Text('Найти авто!'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
