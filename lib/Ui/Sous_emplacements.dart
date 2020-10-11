import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/EmplacementController.dart';
import 'package:inventory_management/Core/Models/Emplacement.dart';
import 'package:inventory_management/Ui/Aj_Sous_Emplacement.dart';
import 'package:inventory_management/Ui/Liste_Article.dart';

import 'Navigation.dart';

class SousEmplacements extends StatefulWidget {
  final String libelle;
  final int id;
  SousEmplacements(this.libelle, this.id);
  @override
  _SousEmplacementsState createState() => _SousEmplacementsState(libelle, id);
}

class _SousEmplacementsState extends State<SousEmplacements> {
  String libelle;
  int id;
  _SousEmplacementsState(this.libelle, this.id);
  List<Emplacement> sousEmplacements;
  getSousEmplacments() {
    EmplacementController.getSousEmplacemens(id).then((response) {
      Iterable list = json.decode(response.body);
      List<Emplacement> emplacementList = List<Emplacement>();
      emplacementList =
          list.map((model) => Emplacement.fromObject(model)).toList();
      setState(() {
        sousEmplacements = emplacementList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getSousEmplacments();
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: AppBar(
        title: Text('Sous Emplacments de $libelle'),
      ),
      body: (sousEmplacements == null || sousEmplacements.length == 0)
          ? Center(
              child: Text('Aucun elemnet a afficher'),
            )
          : _buildEmplacementsList(),
    );
  }
  Widget _buildEmplacementsList() {
    return ListView.builder(
      itemCount: sousEmplacements.length,
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
                        Text(sousEmplacements[index].libelleEmplacement)
                      ],
                    ),
                  ],
                )),
            onTap: () {
              Navigation.navigateToWidget(
                  context,
                  ListeArticles(sousEmplacements[index].libelleEmplacement, sousEmplacements[index].id_emplacement));
            });
      },
    );
  }
 Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (BuildContext context) => AjouterSousEmplacement(id,libelle)));
        });
  }
}
