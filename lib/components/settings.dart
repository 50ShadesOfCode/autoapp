import 'package:auto_app/components/carPage.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarPage(
      carUrl: "http://localhost:5000/getCardByUrl",
    );
  }
}
