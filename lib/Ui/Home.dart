import 'package:flutter/material.dart';
import 'package:inventory_management/Ui/Drawer.dart';
import 'package:inventory_management/Ui/Liste_Comerciaux.dart';
import 'package:inventory_management/Ui/Liste_Emplacements.dart';
import 'package:inventory_management/Ui/Navigation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: new AppBar(
        title: Text("Page d'acceille"),
      ),
      body: Column(
        children: [
          GestureDetector(
            child: Card(
              child: ListTile(
                title: Text("Liste des Emplacements"),
              ),
            ),
            onTap: () => Navigation.navigateToWidget(context, ListeEmplacement()),
          ),
          GestureDetector(
                      child: Card(
              child: ListTile(
                title: Text("Liste des Commerciaux"),
              ),
            ),
            onTap: () => Navigation.navigateToWidget(context, ListeComerciaux()),
          )
        ],
      ),
    );
  }
}
