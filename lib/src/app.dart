import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import './models/image_model.dart';
import './widgets/image_list.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];
  Map<String, dynamic> temp = {};
  Map<String, dynamic> humid = {};
  Map<String, dynamic> light = {};
  Map<String, dynamic> moisture = {};
  List<Map> arr = [];

  void fetchImage() async {
    counter++;
    var response =
        await get('https://jsonplaceholder.typicode.com/photos/$counter');
    var imageModel = ImageModel.fromJson(json.decode(response.body));
    var tempResponse = await get(
        'https://api.thingspeak.com/channels/1322875/fields/1.json?api_key=RES3E1CL3T7GMAUD&results=1');
    var humidResponse = await get(
        'https://api.thingspeak.com/channels/1322875/fields/2.json?api_key=RES3E1CL3T7GMAUD&results=1');
    var lightResponse = await get(
        'https://api.thingspeak.com/channels/1322875/fields/3.json?api_key=RES3E1CL3T7GMAUD&results=1');
    var moistureResponse = await get(
        'https://api.thingspeak.com/channels/1322875/fields/4.json?api_key=RES3E1CL3T7GMAUD&results=1');

    temp = json.decode(tempResponse.body);
    humid = json.decode(humidResponse.body);
    light = json.decode(lightResponse.body);
    moisture = json.decode(lightResponse.body);

    setState(() {
      arr = [];
      images.add(imageModel);
      arr.add(temp["feeds"][0]);
      arr.add(humid["feeds"][0]);
      arr.add(light["feeds"][0]);
      arr.add(moisture["feeds"][0]);
    });

    print(arr);
  }

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images, arr),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: fetchImage,
        ),
        appBar: AppBar(
          title: Text('Lets see some images'),
        ),
      ),
    );
  }
}
