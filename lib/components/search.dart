import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black,
                child: Row(
                  children: [],
                ),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 9,
            )
          ],
        ),
      ),
    );
  }
}
