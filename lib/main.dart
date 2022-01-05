import 'package:flutter/material.dart';
import 'package:slot_machine/slot_machine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SlotMachine(),
    );
  }
}
