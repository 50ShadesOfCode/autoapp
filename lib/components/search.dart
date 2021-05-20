import 'dart:convert';

import 'package:auto_app/components/carListPage.dart';
import 'package:auto_app/utils/urlMaker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

Future<String> _makeUrl(Map<String, dynamic> payload) async {
  var url = Uri.parse("https://constantflame.pythonanywhere.com/makePageUrl");
  var body = json.encode(payload);
  var res = await http.post(url, body: body, headers: headers);
  if (res.statusCode == 200) {
    Map<String, dynamic> jsonRes = json.decode(res.body);
    return jsonRes["url"].toString();
  } else {
    return "";
  }
}

Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json; charset=UTF-8',
};

class Search extends StatefulWidget {
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Поиск"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Container(
                      child: FormBuilderTextField(
                        name: 'mark',
                        decoration: InputDecoration(
                          labelText: 'Марка автомобиля',
                        ),
                        // valueTransformer: (text) => num.tryParse(text),
                        //validator: FormBuilderValidators.compose([
                        //FormBuilderValidators.required(context),
                        //FormBuilderValidators.max(context, 70),
                        //]),
                      ),
                    ),
                    Container(
                      child: FormBuilderTextField(
                        name: 'model',
                        decoration: InputDecoration(
                          labelText: 'Модель автомобиля',
                        ),
                        // valueTransformer: (text) => num.tryParse(text),
                        //validator: FormBuilderValidators.compose([
                        //FormBuilderValidators.required(context),
                        //FormBuilderValidators.max(context, 70),
                        //]),
                      ),
                    ),
                    Container(
                      child: FormBuilderDropdown<String?>(
                          // autovalidate: true,
                          name: 'body',
                          decoration: InputDecoration(
                            labelText: 'Кузов',
                          ),
                          // initialValue: 'Male',
                          allowClear: true,
                          hint: Text('Выберите кузов'),
                          /*validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),*/
                          items: [
                            DropdownMenuItem(
                              value: "SEDAN",
                              child: Text('Седан'),
                            ),
                            DropdownMenuItem(
                              value: "HATCHBACK",
                              child: Text('Хэтчбек'),
                            ),
                            DropdownMenuItem(
                              value: "HATCHBACK_3_DOORS",
                              child: Text('Хэтчбек 3 дв.'),
                            ),
                            DropdownMenuItem(
                              value: "HATCHBACK_5_DOORS",
                              child: Text('Хэтчбек 5 дв.'),
                            ),
                            DropdownMenuItem(
                              value: "LIFTBACK",
                              child: Text('Лифтбек'),
                            ),
                            DropdownMenuItem(
                              value: "ALLROAD",
                              child: Text('Внедорожник'),
                            ),
                            DropdownMenuItem(
                              value: "ALLROAD_3_DOORS",
                              child: Text('Внедорожник 3 дв.'),
                            ),
                            DropdownMenuItem(
                              value: "ALLROAD_5_DOORS",
                              child: Text('Внедорожник 5 дв.'),
                            ),
                            DropdownMenuItem(
                              value: "WAGON",
                              child: Text('Универсал'),
                            ),
                            DropdownMenuItem(
                              value: "COUPE",
                              child: Text('Купе'),
                            ),
                            DropdownMenuItem(
                              value: "MINIVAN",
                              child: Text('Минивэн'),
                            ),
                            DropdownMenuItem(
                              value: "PICKUP",
                              child: Text('Пикап'),
                            ),
                            DropdownMenuItem(
                              value: "LIMOUSINE",
                              child: Text('Лимузин'),
                            ),
                            DropdownMenuItem(
                              value: "VAN",
                              child: Text('Фургон'),
                            ),
                            DropdownMenuItem(
                              value: "CABRIO",
                              child: Text('Кабриолет'),
                            ),
                          ],
                          onChanged: (val) {
                            print(val);
                          }),
                    ),
                    Container(
                      child: FormBuilderDropdown<String?>(
                          // autovalidate: true,
                          name: 'transmission',
                          decoration: InputDecoration(
                            labelText: 'Коробка передач',
                          ),
                          // initialValue: 'Male',
                          allowClear: true,
                          hint: Text('Выберите вид коробки'),
                          /*validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),*/
                          items: [
                            DropdownMenuItem(
                              value: "AUTO",
                              child: Text('Автомат'),
                            ),
                            DropdownMenuItem(
                              value: "AUTOMATIC",
                              child: Text('Автоматическая'),
                            ),
                            DropdownMenuItem(
                              value: "ROBOT",
                              child: Text('Робот'),
                            ),
                            DropdownMenuItem(
                              value: "VARIATOR",
                              child: Text('Вариатор'),
                            ),
                            DropdownMenuItem(
                              value: "MECHANICAL",
                              child: Text('Механическая'),
                            ),
                          ],
                          onChanged: (val) {
                            print(val);
                          }),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 50,
                            child: FormBuilderTextField(
                              name: 'year_from',
                              decoration: InputDecoration(
                                labelText: 'Год от',
                              ),
                              // valueTransformer: (text) => num.tryParse(text),
                              //validator: FormBuilderValidators.compose([
                              //FormBuilderValidators.required(context)//FormBuilderValidators.max(context, 70),
                              //]),
                            ),
                          ),
                          Expanded(
                            flex: 50,
                            child: FormBuilderTextField(
                              name: 'year_to',
                              decoration: InputDecoration(
                                labelText: 'до',
                              ),
                              // valueTransformer: (text) => num.tryParse(text),
                              //validator: FormBuilderValidators.compose([
                              //FormBuilderValidators.required(context),
                              //FormBuilderValidators.max(context, 70),
                              //]),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: FormBuilderDropdown<String?>(
                          // autovalidate: true,
                          name: 'engine_group',
                          decoration: InputDecoration(
                            labelText: 'Двигатель',
                          ),
                          // initialValue: 'Male',
                          allowClear: true,
                          hint: Text('Выберите вид двигателя'),
                          /*validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),*/
                          items: [
                            DropdownMenuItem(
                              value: "GASOLINE",
                              child: Text('Бензин'),
                            ),
                            DropdownMenuItem(
                              value: "DIESEL",
                              child: Text('Дизель'),
                            ),
                            DropdownMenuItem(
                              value: "HYBRID",
                              child: Text('Гибрид'),
                            ),
                            DropdownMenuItem(
                              value: "ELECTRO",
                              child: Text('Электро'),
                            ),
                            DropdownMenuItem(
                              value: "TURBO",
                              child: Text('Турбированный'),
                            ),
                            DropdownMenuItem(
                              value: "ATMO",
                              child: Text('Атмосферный'),
                            ),
                            DropdownMenuItem(
                              value: "LPG",
                              child: Text('Газобалонное оборудование'),
                            ),
                          ],
                          onChanged: (val) {
                            print(val);
                          }),
                    ),
                    Container(
                      child: FormBuilderDropdown<String?>(
                          // autovalidate: true,
                          name: 'gear_type',
                          decoration: InputDecoration(
                            labelText: 'Привод',
                          ),
                          // initialValue: 'Male',
                          allowClear: true,
                          hint: Text('Выберите вид привода'),
                          /*validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),*/
                          items: [
                            DropdownMenuItem(
                              value: "FORWARD_CONTROL",
                              child: Text('Передний'),
                            ),
                            DropdownMenuItem(
                              value: "REAR_DRIVE",
                              child: Text('Задний'),
                            ),
                            DropdownMenuItem(
                              value: "ALL_WHEEL_DRIVE",
                              child: Text('Полный'),
                            ),
                          ],
                          onChanged: (val) {
                            print(val);
                          }),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 50,
                            child: FormBuilderTextField(
                              name: 'km_age_from',
                              decoration: InputDecoration(
                                labelText: 'Пробег от',
                              ),
                              // valueTransformer: (text) => num.tryParse(text),
                              //validator: FormBuilderValidators.compose([
                              //FormBuilderValidators.required(context),
                              //FormBuilderValidators.max(context, 70),
                              //]),
                            ),
                          ),
                          Expanded(
                            flex: 50,
                            child: FormBuilderTextField(
                              name: 'km_age_to',
                              decoration: InputDecoration(
                                labelText: 'до',
                              ),
                              // valueTransformer: (text) => num.tryParse(text),
                              //validator: FormBuilderValidators.compose([
                              //FormBuilderValidators.required(context),
                              //FormBuilderValidators.max(context, 70),
                              //]),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 50,
                            child: FormBuilderTextField(
                              name: 'displacement_from',
                              decoration: InputDecoration(
                                labelText: 'Объем от',
                              ),
                              // valueTransformer: (text) => num.tryParse(text),
                              //validator: FormBuilderValidators.compose([
                              //FormBuilderValidators.required(context),
                              //FormBuilderValidators.max(context, 70),
                              //]),
                            ),
                          ),
                          Expanded(
                            flex: 50,
                            child: FormBuilderTextField(
                              name: 'displacement_to',
                              decoration: InputDecoration(
                                labelText: 'до',
                              ),
                              // valueTransformer: (text) => num.tryParse(text),
                              //validator: FormBuilderValidators.compose([
                              //FormBuilderValidators.required(context),
                              //FormBuilderValidators.max(context, 70),
                              //]),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 50,
                            child: FormBuilderTextField(
                              name: 'price_from',
                              decoration: InputDecoration(
                                labelText: 'Цена от',
                              ),
                              // valueTransformer: (text) => num.tryParse(text),
                              //validator: FormBuilderValidators.compose([
                              //FormBuilderValidators.required(context),
                              //FormBuilderValidators.max(context, 70),
                              //]),
                            ),
                          ),
                          Expanded(
                            flex: 50,
                            child: FormBuilderTextField(
                              name: 'price_to',
                              decoration: InputDecoration(
                                labelText: 'до',
                              ),
                              // valueTransformer: (text) => num.tryParse(text),
                              //validator: FormBuilderValidators.compose([
                              //FormBuilderValidators.required(context),
                              //FormBuilderValidators.max(context, 70),
                              //]),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Найти!",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        _formKey.currentState?.save();
                        if (_formKey.currentState?.validate() == true) {
                          print(_formKey.currentState?.value);
                          String url = makeUrl(_formKey.currentState?.value
                              as Map<String, dynamic>);
                          print(url);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CarListPage(url: url),
                              ));
                        } else {
                          print("validation failed");
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Сбросить",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
