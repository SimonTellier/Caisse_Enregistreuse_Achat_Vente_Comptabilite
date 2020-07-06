import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

String data="";
Map action;
//{"Compte":[{"action":"Vente","heure":"1969-07-20 20:18:04Z","liste":[{"nomPain":"Grosse Boule T80","prix":3.5,"Count":8,},]},]}
//{"Compte":[]}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  if(File('Accounting.txt').existsSync()==false){
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




  void initState() {
    super.initState();
    readContent().then((String value) {
      setState(() {
        if(value=='Error!') {
          writeContent('{"Compte":[{"action":"Vente","heure":"1969-07-20 20:18:04Z","liste":[{"nomPain":"Grosse Boule T80","prix":3.5,"Count":8}]}]}');
          value='{"Compte":[{"action":"Vente","heure":"1969-07-20 20:18:04Z","liste":[{"nomPain":"Grosse Boule T80","prix":3.5,"Count":8}]}]}';
        }
        data = value;
        action = jsonDecode(data);

      });
    });
  }
  Widget build(BuildContext context){

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
           child: Text("test"+
            //'Data read from a file: \n '+action["Compte"][0]["action"]+"\n"+
             'Data read from a file: \n '+data,

           ),
          ),
      ),
    );
  }
}