import 'package:flutter/material.dart';
import 'ui/home.dart';

void main() {
  runApp(BillSplitterApp());
}

class BillSplitterApp extends StatelessWidget {

  const BillSplitterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill Splitter',
      theme: ThemeData(primarySwatch: Colors.blue, appBarTheme: AppBarTheme(
        backgroundColor: Colors.green[100]
      )),
      home: const HomePage(),
    );
  }
}
