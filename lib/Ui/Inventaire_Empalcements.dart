import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/EmplacementController.dart';
import 'package:inventory_management/Core/Models/Emplacement.dart';
import 'package:inventory_management/Ui/Inventaire_SousEmplacements.dart';
import 'package:inventory_management/Ui/Navigation.dart';
import 'package:inventory_management/Ui/Sous_emplacements.dart';
class InventaireEmplacements extends StatefulWidget {
  @override
  _InventaireEmplacementsState createState() => _InventaireEmplacementsState();
}

class _InventaireEmplacementsState extends State<InventaireEmplacements> {
    List<Emplacement> mesEmplacements;
  getEmplacments() {
    EmplacementController.getEmplacement().then((response) {
      Iterable list = json.decode(response.body);
      List<Emplacement> emplacementList = List<Emplacement>();
      emplacementList =
          list.map((model) => Emplacement.fromObject(model)).toList();
      setState(() {
        mesEmplacements = emplacementList;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
      getEmplacments();
    return Scaffold(
      appBar: AppBar(
        title: Text('Sellectionner un Emplacment'),
      ),
      body: (mesEmplacements == null || mesEmplacements.length == 0)
          ? Center(
              child: Text('Aucun elemnet a afficher'),
            )
          : _buildEmplacementsList(),
    );
  }
  
  Widget _buildEmplacementsList() {
    return ListView.builder(
      itemCount: mesEmplacements.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            child: Card(
                color: Colors.blue[50],
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(mesEmplacements[index].libelleEmplacement),
                      ],
                    ),
                  ],
                )),
            onTap: () {
              Navigation.navigateToWidget(
                  context,
                  InventaireSousEmplacements(mesEmplacements[index].libelleEmplacement,
                      mesEmplacements[index].id_emplacement));
            });
      },
    );
  }
}