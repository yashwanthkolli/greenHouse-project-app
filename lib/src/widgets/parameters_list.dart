import 'package:flutter/material.dart';
import '../models/parameter_model.dart';

class ParametersList extends StatelessWidget {
  final List<ParameterModel> arr;

  ParametersList(this.arr);

  Widget build(context) {
    return ListView.builder(
      itemCount: arr.length,
      itemBuilder: (context, int index) {
        var value;
        if (arr[index].field != null) {
          value = arr[index].field;
        } else {
          value = "0";
        }
        return Text(arr[index].name + ": " + value);
      },
    );
  }
}
