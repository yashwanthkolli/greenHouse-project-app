import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;
  final List<Map> arr;

  ImageList(this.images, this.arr);

  Widget build(context) {
    return ListView.builder(
      itemCount: arr.length,
      itemBuilder: (context, int index) {
        return Text(arr[index]["created_at"]);
      },
    );
  }
}
