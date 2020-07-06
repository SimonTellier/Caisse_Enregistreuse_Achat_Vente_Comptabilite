import 'package:flutter/material.dart';
import 'package:cash_register/pages/home_widget.dart';




void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cash_Register',
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
