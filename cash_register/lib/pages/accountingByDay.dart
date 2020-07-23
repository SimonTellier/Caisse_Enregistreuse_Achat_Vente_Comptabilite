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
    return Material(
        child: Column(
            children: <Widget>[
          Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.green,
                            size: 30.0,
                          ),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              this.dayChoisi["Day"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            )),
                        Container(
                          child: Text(_sommeParJour().toStringAsFixed(2) + "€"),
                        ),
                      ],
                    ),
                  ))),
          Expanded(
              flex: 12,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: this.dayChoisi["Liste"].length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF8D6E63),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                        ),
                        child: ExpansionTile(
                            backgroundColor: Colors.brown,

                            // key: new PageStorageKey<int>(3),
                            title: new Text(DateFormat.Hm("fr").format(
                                DateFormat('yyyy-MM-dd HH:mm').parse(
                                    this.dayChoisi["Liste"][index]["date"]))),
                            subtitle: Text(
                              _sommeParCommande(index).toStringAsFixed(2) + "€",
                              textAlign: TextAlign.right,
                            ),
                            //this.dayChoisi["Liste"][index]["date"] + " "),
                            children: <Widget>[
                              ListView.builder(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                      left: 0, right: 0, top: 0, bottom: 4),
                                  itemCount: this
                                      .dayChoisi["Liste"][index]
                                          ["listePainVendu"]
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int index2) {
                                    return new Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      )),
                                      child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 0.0),
                                          title: Text(this.dayChoisi["Liste"]
                                                      [index]["listePainVendu"]
                                                  [index2]["nomPain"] +
                                              " *" +
                                              this
                                                  .dayChoisi["Liste"][index]
                                                      ["listePainVendu"][index2]
                                                      ["Count"]
                                                  .toString()),
                                          subtitle: Text(
                                            _sommeParProduit(index, index2)
                                                    .toStringAsFixed(2) +
                                                "€",
                                            textAlign: TextAlign.right,
                                          )),
                                    );
                                  }),
                            ]));
                  }))
        ]));
  }

  double _sommeParCommande(int index) {
    double somme = 0;
    for (var i = 0;
        i < this.dayChoisi["Liste"][index]["listePainVendu"].length;
        i++) {
      somme = this.dayChoisi["Liste"][index]["listePainVendu"][i]["prix"] *
              this.dayChoisi["Liste"][index]["listePainVendu"][i]["Count"] +
          somme;
    }
    return somme;
  }

  double _sommeParProduit(int index, int index2) {
    double somme = 0;
    somme = this.dayChoisi["Liste"][index]["listePainVendu"][index2]["prix"] *
        this.dayChoisi["Liste"][index]["listePainVendu"][index2]["Count"];
    return somme;
  }

  double _sommeParJour() {
    double somme = 0;
    for (var i = 0; i < this.dayChoisi["Liste"].length; i++) {
      for (var j = 0;
          j < this.dayChoisi["Liste"][i]["listePainVendu"].length;
          j++) {
        somme = this.dayChoisi["Liste"][i]["listePainVendu"][j]["prix"] *
                this.dayChoisi["Liste"][i]["listePainVendu"][j]["Count"] +
            somme;
      }
    }
    return somme;
  }
}
