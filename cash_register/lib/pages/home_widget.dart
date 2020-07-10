import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cash_register/fragments/first_fragment.dart';
import 'package:cash_register/fragments/second_fragment.dart';
import 'package:cash_register/fragments/third_fragment.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';







class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}


class _HomePageState extends State<HomePage> {
  int _currentIndex=1;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new FirstFragment();
      case 1:
        return new SecondFragment();
      case 2:
        return new ThirdFragment();
      default:
        return new Text("Error NavigationBar");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0), // here the desired height
    child: AppBar(
        title: Text('Cash_Register'),
      ),
      ),
      body: _getDrawerItemWidget(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, //pour ne pas avoir de bugs avec plus de 3 boutons
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.cart,),
                title: Text('Achat'),
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.cashMultiple),
                title: Text('Vente'),
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.clipboardOutline),
                title: Text('Compte'),
              ),
            ],
          ),
      );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}