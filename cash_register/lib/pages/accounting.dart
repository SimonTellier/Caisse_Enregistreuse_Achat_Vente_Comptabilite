import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';



String data="";
Map action={"Compte":[]};
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

  List<DateTime> dayListe= [];




  void initState() {
    super.initState();
    initializeDateFormatting();
    readContent().then((String value) {
      setState(() {
        if(value=='Error!') {
          writeContent('{"Compte":[]}');
          value='{"Compte":[]}';
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
        body: body()


      ),
    );
  }
  List<DateTime> Day(){
    dayListe= [];

    for (var i = 0; i<action["Compte"].length;i++){
      if(!dayListe.contains(DateFormat('yyyy-MM-dd').parse(action["Compte"][i]["date"]))){
        dayListe.add(DateFormat('yyyy-MM-dd').parse(action["Compte"][i]["date"]));
        print(DateFormat.yMMMMEEEEd("fr").format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(action["Compte"][i]["date"])));
        print("2EME Print : "+action["Compte"][i]["date"]);
      }

    }

    return dayListe;
  }

  Widget body(){
    dayListe = Day();
    if(dayListe.isEmpty){
      print("if");
      return Container(
          child: Text("salut")
      );
    }
    else{
      return new ListView.builder(

        itemCount: data == null ? 0 : Day().length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              //dayListe
              title: Text(DateFormat.yMMMMEEEEd("fr").format(dayListe[index])),
              subtitle: Text(data),
              trailing: IconButton(icon: Icon(Icons.arrow_forward_ios)),
            //onTap: (){ Navigator.push(context,MaterialPageRoute(builder: (context) => PlayListEnCours(indexEnCours: index)));},
            ),
              shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        );
      },
    );
    }
  }
}