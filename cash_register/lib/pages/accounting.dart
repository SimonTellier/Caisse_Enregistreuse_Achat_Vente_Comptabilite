import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cash_register/pages/accountingByDay.dart';

String data = "";
Map action = {"Compte": []};

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  if (File('Accounting.txt').existsSync() == false) {
    new File('$path/Accounting.txt');
  }
  return File('$path/Accounting.txt');
}

Future<File> writeContent(String d) async {
  final file = await _localFile;
  return file.writeAsString(d);
}

Future<String> readContent() async {
  try {
    final file = await _localFile;
    // Read the file
    String contents = await file.readAsString();
    // Returning the contents of the file
    return contents;
  } catch (e) {
    // If encountering an error, return
    return 'Error!';
  }
}

class Accounting extends StatefulWidget {
  Accounting() : super();

  @override
  AccountingState createState() => AccountingState();
}

class AccountingState extends State<Accounting> {
  @override
  Map dayListe = {"ParJour": []};

  void initState() {
    super.initState();
    initializeDateFormatting();
    readContent().then((String value) {
      setState(() {
        if (value == 'Error!') {
          writeContent('{"Compte":[]}');
          value = '{"Compte":[]}';
        }
        data = value;
        action = trierJour(jsonDecode(data));
        dayListe = Day();

      });
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(child: body()),
    );
  }

  Map Day() {
    dayListe = {"ParJour": []};
    for (var i = action["Compte"].length - 1; i >= 0; i--) {
      bool dayIsHere = false;
      for (var j = 0; j < dayListe["ParJour"].length; j++) {
        if (dayListe["ParJour"][j]["Day"].contains(DateFormat.yMMMMEEEEd("fr")
            .format(
                DateFormat('yyyy-MM-dd').parse(action["Compte"][i]["date"])))) {
          dayListe["ParJour"][j]["Liste"].add(action["Compte"][i]);
          dayIsHere = true;
        }
      }
      if (!dayIsHere) {
        dayListe["ParJour"].add({
          "Day": DateFormat.yMMMMEEEEd("fr").format(
              DateFormat('yyyy-MM-dd').parse(action["Compte"][i]["date"])),
          "Liste": []
        });
        dayListe["ParJour"][dayListe["ParJour"].length - 1]["Liste"]
            .add(action["Compte"][i]);
      }
    }
    return dayListe;
  }

  Widget body() {
    dayListe = Day();
    if (dayListe["ParJour"].isEmpty) {
      print("if");

      return Container(child: Text("La liste action est vide"));
    } else {
      return new  ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: data == null ? 0 : Day()["ParJour"].length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                child: Card(
                  margin: EdgeInsets.only(top: 5),

                  color: Colors.green,
                  child: ListTile(
                    title: Text(
                      dayListe["ParJour"][index]["Day"],
                      style: TextStyle(backgroundColor: Colors.blue),
                    ),
                    trailing: IconButton(icon: Icon(Icons.arrow_forward_ios)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountingByDay(
                                  dayChoisi: dayListe["ParJour"][index])));
                    },
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              );
            },
          );
    }
  }
  trierJour(Map jsonPasTrier){
    Map jsonTrier = {"Compte": []};
      json
    return jsonPasTrier;
  }
}
