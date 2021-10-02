import 'package:flutter/material.dart';

class Sizing {
  BuildContext context;
  Size _size = Size.zero;
  double _height = 0;
  double _width = 0;

  Sizing({required this.context}) {
    _size = MediaQuery.of(context).size;
    _height = _size.height;
    _width = _size.width;
  }

  height({double percent = 100}) {
    return _height * (percent / 100);
  }
  width({double percent = 100}){
    return _width * (percent/100);
  }
}
