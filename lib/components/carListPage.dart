import 'package:flutter/material.dart';

import 'carCard.dart';

List<String> cards = [
  "assf",
  "saf",
  "saf",
  "saf",
  "saf",
  "saf",
  "saf",
  "saf",
  "saf",
  "saf",
  "saf",
  "saf",
  "saf",
];

class CarListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  return CarCard(cardUrl: cards[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
