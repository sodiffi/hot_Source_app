import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InfoState();
  }
}

class InfoState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return (Container(
      child: Text("這邊是資訊"),
    ));
  }
}
