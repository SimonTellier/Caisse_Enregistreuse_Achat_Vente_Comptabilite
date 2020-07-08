import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cash_register/pages/accounting.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';


class Sell extends StatefulWidget {
  Sell() : super();

  @override
  SellState createState() => SellState();
}

double total = 0;
List<Choice> choices =  <Choice>[
  Choice(id: 0, title: 'Grosse Boule T80', prix :4.5 ,icon: 'assets/icons/bread.svg'),
  Choice(id: 1, title: 'Pain de mie T80', prix :4.5 , icon: 'assets/icons/pain_de_mie.svg'),
  Choice(id: 2, title: 'Grosse Boule T150', prix :4.5 , icon: 'assets/icons/bread.svg'),
  Choice(id: 3, title: 'Tourte de Seigle', prix :3.5 , icon: 'assets/icons/bread.svg'),
];
List<Choice> listes =  <Choice>[];

class Choice {
  Choice({this.id, this.title,this.prix,this.icon});
  final int id;
  int _count=0;
  final String title;
  final double prix;
  final String icon;
}

class SellState extends State<Sell> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded( //Liste des pains
              flex: 6,
              child: GridView.count(
                padding: EdgeInsets.all(5.0),
                crossAxisCount: 2,
                physics: ScrollPhysics(),

                // Generate 100 widgets that display their index in the List.
                children: List.generate(choices.length, (index) {
                  return

                    Center(
                        child: GridTile(
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              child: InkWell(
                                  onTap: () =>_incrementCounter(choices[index]),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      color: Color(0xFFF5F5F5),
                                      child: Center(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              SvgPicture.asset(choices[index].icon, height: 40.0,),
                                              Text(choices[index].title, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                              Text(choices[index].prix.toStringAsFixed(2)+"€", textAlign: TextAlign.center,),
                                            ]),
                                      ))),
                            ))
                    );
                }),
              ),
            ),
            Expanded(
              flex:3,
              child:
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
                    left: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
                    right: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
                  ),
                  color: Color(0xFFF5F5F5),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(//My order
                        flex:2,
                        child:
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration:  BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
                            ),
                            color: Color(0xFFF5F5F5),
                          ),
                          padding: EdgeInsets.only(left:20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("My\nOrder",style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      Expanded(//----------Liste des achats----
                        flex:7,
                        child: GridView.count(
                          crossAxisCount: 1,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.all(0.5),
                          children: List.generate(listes.length, (index) {
                            return Center(
                                child: GridTile(
                                    child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: InkWell(
                                          //onTap: () =>_incrementCounter(choices[index]),
                                            child: Card(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                                                color: Colors.grey[300],
                                                child: Center(
                                                  child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        SvgPicture.asset(listes[index].icon, height: 20.0,),
                                                        Text(listes[index].title, style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                                        Text((listes[index].prix*listes[index]._count).toStringAsFixed(2)+"€",textAlign: TextAlign.center,),
                                                        Container(
                                                            child : Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                crossAxisAlignment: CrossAxisAlignment.center,

                                                                children: <Widget>[
                                                                  InkWell(
                                                                    onTap: () =>_decreaseCounter(listes[index],index),
                                                                    child:Container(
                                                                      width: 25,
                                                                      height: 15,
                                                                      decoration: BoxDecoration(
                                                                        color: Color(0xFFF5F5F5),
                                                                        borderRadius: BorderRadius.all(
                                                                            Radius.circular(5.0) //         <--- border radius here
                                                                        ),
                                                                        border: Border.all(
                                                                          color: Colors.grey,
                                                                          width: 1,
                                                                        ),
                                                                      ),
                                                                      child: Text("-",textAlign: TextAlign.center,  style: TextStyle(fontSize: 10),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                      padding: const EdgeInsets.all(2.0),
                                                                      width: 25,
                                                                      height: 22,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.grey[300],
                                                                        borderRadius: BorderRadius.all(
                                                                            Radius.circular(5.0) //         <--- border radius here
                                                                        ),
                                                                      ),
                                                                      child: Text(listes[index]._count.toString(),textAlign: TextAlign.center,)
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () =>_incrementCounter(listes[index]),
                                                                    child:Container(
                                                                      width: 25,
                                                                      height: 15,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.amber,
                                                                        borderRadius: BorderRadius.all(
                                                                            Radius.circular(5.0) //         <--- border radius here
                                                                        ),
                                                                        border: Border.all(
                                                                          color: Colors.amber,
                                                                          width: 1,
                                                                        ),
                                                                      ),
                                                                      child: Text("+",textAlign: TextAlign.center,  style: TextStyle(fontSize: 10),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]
                                                            )
                                                        )
                                                      ]),
                                                )))
                                    )
                                )
                            );
                          }),
                        ),),
                      Expanded(//Total
                        flex:2,

                        child:
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
                            ),
                            color: Color(0xFFF5F5F5),
                          ),

                          child: Column(
                            children: [
                              Expanded(//TOTAL
                                flex:1,
                                child:
                                Container(
                                  padding: EdgeInsets.only(bottom:5.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text("Total"),
                                  ),),
                              ),
                              Expanded(//Prix
                                flex:1,
                                child:Container(
                                  padding: EdgeInsets.only(top:5.0),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(total.toStringAsFixed(2)+"€",style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),),
                              ),
                              Expanded(//VALIDER
                                flex:1,
                                child:Container(
                                  padding: EdgeInsets.only(top:5.0,bottom: 5.0),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: InkWell(
                                      child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: BorderSide(color: Colors.white)),
                                          color: Colors.green,
                                          onPressed: () => _saveToAccounting(listes),//_resetAllCounter,
                                          textColor: Colors.white,
                                          child: Text("VALIDER")),
                                    ),),),
                              ),],),

                        ),
                      ),
                    ]
                ),
              ),
            ),],
        ),
      ),
      );
  }
   _saveToAccounting(List<Choice> L){
    if(listes.toString()!="[]"){
      var now = DateTime.now();
      Map insert = {
        "action":"Vente",
        "date":now.toString(),
        "liste":[]
      };
      for (var i = 0; i< listes.length;i++){
        insert["liste"].add({
          "nomPain":L[i].title,
          "prix":L[i].prix,
          "Count":L[i]._count
        });
      }
      action["Compte"].add(insert);
      data = jsonEncode(action);
      writeContent(data);
      _resetAllCounter();
    }
  }
  _decreaseCounter(Choice choice,int index){
    setState(() {
      if(choice._count==1){
        listes[index]._count=0;
        listes.remove(choice);
        total=total-choice.prix;
      }
      else{
        listes[index]._count--;
        total=total-choice.prix;
      }
      total=0;
      for (var i = 0; i< listes.length;i++){
        total=listes[i].prix*listes[i]._count+total;
      }
    });
  }
  void _resetAllCounter(){
    setState(() {
      total=0;
      listes.clear();
      for (var i = 0; i< choices.length;i++){
        choices[i]._count=0;
      }
    });
  }
  _incrementCounter(Choice choice) {
    setState(() {
      bool dedans=false;
      int index = 0;
      for (var i = 0; i< listes.length;i++) {
        if(listes[i].title==choice.title){
          dedans=true;
          index=i;
        }
      }
      if(dedans){
        listes[index]._count++;
      }
      else{
        listes.add(choice);
        listes[listes.length-1]._count++;
      }
      total=0;
      for (var i = 0; i< listes.length;i++){
        total=listes[i].prix*listes[i]._count+total;
      }
    });
  }
}
