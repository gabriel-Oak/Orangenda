import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';
import 'package:flutter_agenda/pages/home/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ContactHelper repository = ContactHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orangenda',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(repository: repository),
    );
  }
}
