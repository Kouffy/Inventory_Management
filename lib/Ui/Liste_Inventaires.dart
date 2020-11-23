import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/InventaireController.dart';
import 'package:inventory_management/Core/Models/Inventaire.dart';

class ListeInventaire extends StatefulWidget {
  @override
  _ListeInventaireState createState() => _ListeInventaireState();
}

class _ListeInventaireState extends State<ListeInventaire> {
  List<Inventaire> mesInventaires;
  getInventaires() {
    InventaireController.getInventaire().then((response) {
      Iterable list = json.decode(response.body);
      List<Inventaire> inventaireList = List<Inventaire>();
      inventaireList =
          list.map((model) => Inventaire.fromObject(model)).toList();
      if (this.mounted) {
        setState(() {
          mesInventaires = inventaireList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getInventaires();
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: AppBar(
        title: Text('Emplacments'),
      ),
      body: (mesInventaires == null || mesInventaires.length == 0)
          ? Center(
              child: Text('Aucun elemnet a afficher'),
            )
          : _buildInventairesList(),
    );
  }

  Widget _buildInventairesList() {
    return ListView.builder(
      itemCount: mesInventaires.length,
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
                        Text(mesInventaires[index].date_inventaire)
                      ],
                    ),
                  ],
                )),
            onTap: () {});
      },
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (BuildContext context) => null));
        });
  }
}
