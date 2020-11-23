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
              child: ListTile(
                title: Text(mesEmplacements[index].libelleEmplacement),
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
                          onPressed: () => Navigation.navigateToWidget(context,
                              AjouterEmplacement(mesEmplacements[index])),
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
                              mesEmplacements[index].id_emplacement),
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
                  SousEmplacements(mesEmplacements[index].libelleEmplacement,
                      mesEmplacements[index].id_emplacement));
            });
      },
    );
  }

  Container buildSearchContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white70),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              blurRadius: 3,
              offset: Offset(0, 3),
            )
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: TextField(
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            fillColor: Colors.grey[500],
            icon: Icon(Icons.search),
          ),
          maxLines: 1,
          textInputAction: TextInputAction.search,
        ),
      ),
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
