import 'package:flutter/material.dart';
import 'package:inventory_management/Ui/Drawer.dart';
class HomeCommercial extends StatefulWidget {
  @override
  _HomeCommercialState createState() => _HomeCommercialState();
}

class _HomeCommercialState extends State<HomeCommercial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: new AppBar(title: Text("Page d'acceille"),),
      body: Column(
children: [
  Card(
    child: ListTile(
      title: Text("Effectuer un Inventaire"),
    ),
  ),
    Card(
    child: ListTile(
      title: Text("Liste des Inventaires"),
    ),
  )
],
      ),
    );
  }
}