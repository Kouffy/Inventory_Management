import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventory_management/Core/Controllers/ArticleController.dart';
import 'package:inventory_management/Core/Controllers/CommercialController.dart';
import 'package:inventory_management/Core/Models/Commercial.dart';
import 'package:inventory_management/Toasts.dart';
import 'package:inventory_management/Ui/Aj_Commercial.dart';
import 'package:inventory_management/Ui/Navigation.dart';
class ListeComerciaux extends StatefulWidget {
  @override
  _ListeComerciauxState createState() => _ListeComerciauxState();
}

class _ListeComerciauxState extends State<ListeComerciaux> {
  List<Commercial> listCommerciaux;
  getComerciaux(){
    CommercialController.getCommercial().then((response) {
      Iterable list = json.decode(response.body);
      List<Commercial> comercialList = List<Commercial>();
      comercialList = list.map((model) => Commercial.fromObject(model)).toList();
      setState(() {
        listCommerciaux = comercialList;
      }); 
    });
  }
  @override
  Widget build(BuildContext context) {
    getComerciaux();
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      appBar: AppBar(
        title: Text('Les Commerciaux'),
      ),
      body: (listCommerciaux == null || listCommerciaux.length == 0)
          ? Center(
              child: Text('Aucun elemnet a afficher'),
            )
          : _buildCommerciauxList(),
    );
  }
  
  Widget _buildCommerciauxList() {
    return ListView.builder(
      itemCount: listCommerciaux.length,
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
                        Text(listCommerciaux[index].nomCommercial + " " + listCommerciaux[index].prenomCommercial),
                         SizedBox(
                          width: 10.0,
                        ),
                        RaisedButton(
                          child: Text(
                            "Modifier",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () => Navigation.navigateToWidget(context, AjouterCommercial(listCommerciaux[index])),
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
                          onPressed: () => supprimerCommercial(listCommerciaux[index].idCommercial),
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
             // Navigation.navigateToWidget(context, null);
            });
      },
    );
  }
    Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (BuildContext context) => AjouterCommercial(null)));
        });
  }
      void supprimerCommercial(int id) async {
    var saveResponse = await CommercialController.deleteCommercial(id);
    saveResponse == true
        ? Toasts.showSucssesToast("supprimé avec succès")
        : Toasts.showFailedToast("Erreur");
  }
}