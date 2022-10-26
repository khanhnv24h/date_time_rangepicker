import 'package:flutter/material.dart';
import 'package:sql_demo/screens/date_range_picker.dart';
import 'package:sql_demo/utils/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: themeColor,
      ),
      home: const DateRangePicker(),
    );
  }
}
