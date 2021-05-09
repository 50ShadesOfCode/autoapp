import 'package:flutter/material.dart';

import 'carCard.dart';

List<String> cardUrls = [
  "https://auto.ru/cars/used/sale/mercedes/gle_klasse_coupe/1103168273-6ac4b173/",
  "https://auto.ru/cars/used/sale/toyota/tundra/1101441177-02a09f7a/",
];

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FavListScreen(),
    );
  }
}

class FavListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cardUrls.length,
              itemBuilder: (BuildContext context, int index) {
                return CarCard(cardUrl: cardUrls[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
