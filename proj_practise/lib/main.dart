import 'package:flutter/material.dart';

import 'package:proj_practise/gradient_container.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GradientContainer.purple(),
        // body: GradientContainer(
        //   Color.fromARGB(255, 33, 5, 109),
        //   Color.fromARGB(255, 68, 21, 149),
        // ),
      ),
    ),
  );
}
