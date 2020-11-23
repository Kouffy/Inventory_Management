import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/EmplacementController.dart';
import 'package:inventory_management/Core/Models/Emplacement.dart';
import 'package:inventory_management/Toasts.dart';
import 'package:inventory_management/Ui/Aj_Emplacement.dart';
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
      if (this.mounted) {
        setState(() {
          sousEmplacements = emplacementList;
        });
      }
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
              child: ListTile(
                title: Text(sousEmplacements[index].libelleEmplacement),
                leading: Image.asset(
                  "assets/images/emplacement.png",
                  height: 40,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RaisedButton(
                      child: Text(
                        "Modifier",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () => Navigation.navigateToWidget(
                          context, AjouterEmplacement(sousEmplacements[index])),
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.grey,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    RaisedButton(
                      child: Text(
                        "Supprimer",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () => supprimerEmplacement(
                          sousEmplacements[index].id_emplacement),
                      color: Colors.red,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigation.navigateToWidget(
                  context,
                  ListeArticles(sousEmplacements[index].libelleEmplacement,
                      sousEmplacements[index].id_emplacement));
            });
      },
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) =>
                  AjouterSousEmplacement(id, libelle)));
        });
  }

  void supprimerEmplacement(int id) async {
    var saveResponse = await EmplacementController.deleteEmplacement(id);
    saveResponse == true
        ? Toasts.showSucssesToast("supprimé avec succès")
        : Toasts.showFailedToast("Erreur");
  }
}
