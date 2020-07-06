import 'package:flutter/material.dart';

class Buy extends StatefulWidget {
  Buy() : super();

  @override
  BuyState createState() => BuyState();


}

class BuyState extends State<Buy> {


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(),
      ),
    );
  }
}