import 'package:cash_register/pages/accounting.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class AccountingByDay extends StatelessWidget {
  final Map dayChoisi;
  final ScrollController _scrollController = ScrollController();

  AccountingByDay({this.dayChoisi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown,
        body: Column(children: [
          Expanded(
              flex: 1,
              child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFBCAAA4),
                    border: Border.all(
                      color: Color(0xFF8D6E63),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        this.dayChoisi["Day"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      )))),
          Expanded(
              flex: 11,
              child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: this.dayChoisi["Liste"].length,
                  itemBuilder: (BuildContext context, int index) {
                    return new ExpansionTile(
                       // key: new PageStorageKey<int>(3),
                        title: new Text(DateFormat.Hm("fr").format(DateFormat('yyyy-MM-dd HH:mm').parse(this.dayChoisi["Liste"][index]["date"]))),
                            //this.dayChoisi["Liste"][index]["date"] + " "),
                        children: <Widget>[
                          ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: this.dayChoisi["Liste"][index]["listePainVendu"].length,
                                itemBuilder: (BuildContext context, int index2) {
                                  return new Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0),
                                    )),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 0.0),
                                       title: Text(this.dayChoisi["Liste"][index]["listePainVendu"][index2]["nomPain"]+" *"+this.dayChoisi["Liste"][index]["listePainVendu"][index2]["Count"].toString()),

                                    ),
                                  );
                                }),
                        ]);
                  }))
        ]));
  }
}
