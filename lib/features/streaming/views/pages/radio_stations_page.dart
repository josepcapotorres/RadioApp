import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class RadioStationsPage extends StatelessWidget {
  static const routeName = "radio_stations";

  const RadioStationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Radio stations streaming"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Emisoras",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(child: StationsList()),
          ],
        ),
      ),
    );
  }
}
