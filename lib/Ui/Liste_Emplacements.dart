import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/EmplacementController.dart';
import 'package:inventory_management/Core/Models/Emplacement.dart';
import 'package:inventory_management/Toasts.dart';
import 'package:inventory_management/Ui/Aj_Emplacement.dart';
import 'package:inventory_management/Ui/Navigation.dart';
import 'package:inventory_management/Ui/Sous_emplacements.dart';

class ListeEmplacement extends StatefulWidget {
  @override
  _ListeEmplacementState createState() => _ListeEmplacementState();
}

class _ListeEmplacementState extends State<ListeEmplacement> {
  List<Emplacement> mesEmplacements;
  getEmplacments() {
    EmplacementController.getEmplacement().then((response) {
      Iterable list = json.decode(response.body);
      List<Emplacement> emplacementList = List<Emplacement>();
      emplacementList =
          list.map((model) => Emplacement.fromObject(model)).toList();
      if (this.mounted) {
        setState(() {
          mesEmplacements = emplacementList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getEmplacments();
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: AppBar(
        title: Text('Emplacments'),
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
                        SizedBox(
                          width: 10.0,
                        ),
                        RaisedButton(
                          child: Text(
                            "Modifier",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () => Navigation.navigateToWidget(context,
                              AjouterEmplacement(mesEmplacements[index])),
                          color: Colors.green,
                          textColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.grey,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        RaisedButton(
                          child: Text(
                            "Supprimer",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () => supprimerEmplacement(
                              mesEmplacements[index].id_emplacement),
                          color: Colors.green,
                          textColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                )),
            onTap: () {
              Navigation.navigateToWidget(
                  context,
                  SousEmplacements(mesEmplacements[index].libelleEmplacement,
                      mesEmplacements[index].id_emplacement));
            });
      },
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => AjouterEmplacement(null)));
        });
  }

  void supprimerEmplacement(int id) async {
    var saveResponse = await EmplacementController.deleteEmplacement(id);
    saveResponse == true
        ? Toasts.showSucssesToast("supprimé avec succès")
        : Toasts.showFailedToast("Erreur");
  }
}
