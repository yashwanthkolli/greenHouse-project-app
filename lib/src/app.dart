import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import './models/parameter_model.dart';
import './widgets/parameters_list.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  Map<String, String> parameters = {
    'temp': 'Temprature',
    'humid': 'Humidity',
    'light': 'Light',
    'moisture': 'Moisture'
  };
  Map<String, dynamic> temp = {};
  Map<String, dynamic> humid = {};
  Map<String, dynamic> light = {};
  Map<String, dynamic> moisture = {};
  List<ParameterModel> arr = [];

  void fetchData() async {
    var tempResponse = await get(
        'https://api.thingspeak.com/channels/1322875/fields/1.json?api_key=RES3E1CL3T7GMAUD&results=1');
    var humidResponse = await get(
        'https://api.thingspeak.com/channels/1322875/fields/2.json?api_key=RES3E1CL3T7GMAUD&results=1');
    var lightResponse = await get(
        'https://api.thingspeak.com/channels/1322875/fields/3.json?api_key=RES3E1CL3T7GMAUD&results=1');
    var moistureResponse = await get(
        'https://api.thingspeak.com/channels/1322875/fields/4.json?api_key=RES3E1CL3T7GMAUD&results=1');

    temp = json.decode(tempResponse.body)["feeds"][0];
    humid = json.decode(humidResponse.body)["feeds"][0];
    light = json.decode(lightResponse.body)["feeds"][0];
    moisture = json.decode(moistureResponse.body)["feeds"][0];

    var tempModel = ParameterModel.create(
        'Temprature', temp["entry_id"], temp["created_at"], temp["field1"]);

    var humidModel = ParameterModel.create(
        "Humidity", humid["entry_id"], humid["created_at"], humid["field2"]);

    var lightModel = ParameterModel.create(
        "Light", light["entry_id"], light["created_at"], light["field3"]);

    var moistureModel = ParameterModel.create("Moisture", moisture["entry_id"],
        moisture["created_at"], moisture["field4"]);

    setState(() {
      arr = [];
      arr.addAll([tempModel, humidModel, lightModel, moistureModel]);
    });
  }

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: ParametersList(arr),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: fetchData,
        ),
        appBar: AppBar(
          title: Text('GreenHouse Project'),
        ),
      ),
    );
  }
}
