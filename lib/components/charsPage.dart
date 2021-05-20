import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CharsPage extends StatefulWidget {
  final String url;
  CharsPage({required String url}) : this.url = url;
  _CharsPageState createState() => _CharsPageState(this.url);
}

class _CharsPageState extends State<CharsPage> {
  final String url;
  _CharsPageState(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
      future: _getParams(this.url),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snap) {
        return ListView.builder(
          itemCount: snap.data?.length,
          itemBuilder: (BuildContext context, int index) {
            String key = (snap.data?.keys.elementAt(index)).toString();
            print(snap.data);
            return Container(
              margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
              child: Row(
                children: [
                  Expanded(
                    child: Text(key),
                    flex: 50,
                  ),
                  Expanded(
                    flex: 50,
                    child: Text((snap.data?[key]).toString()),
                  )
                ],
              ),
            );
          },
        );
      },
    ));
  }
}

Future<Map<String, dynamic>> _getParams(String url) async {
  var res = await http.post(
    Uri.parse('https://autoparseru.herokuapp.com/getCharsByUrl'),
    body: json.encode({"url": url}),
    headers: headers,
  );
  if (res.statusCode == 200) {
    Map<String, dynamic> vals = json.decode(res.body);
    return vals;
  }
  Map<String, dynamic> l = Map<String, dynamic>();
  return l;
}

Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json; charset=UTF-8',
};
