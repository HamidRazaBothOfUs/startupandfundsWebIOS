
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocalCircularImage extends StatefulWidget {
  LocalCircularImage({required this.imagePath, required this.size});
  String imagePath;
  double size;

  @override
  State<StatefulWidget> createState() => _LocalCircularImageState(imagePath: imagePath, size: size);
}
class _LocalCircularImageState extends State<LocalCircularImage> {
  _LocalCircularImageState({required this.imagePath, required this.size});
  String imagePath;
  double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: CircleAvatar(
        radius: size,
        backgroundImage: NetworkImage(imagePath),
      ),
    );
  }
}